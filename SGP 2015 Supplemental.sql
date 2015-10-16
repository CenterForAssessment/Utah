------ 1. 2015 STUDENTS POTENTIALLY MISSING SGPs (N = 72,566; 0min:50sec)
SELECT DISTINCT
       SchoolYear,
       TestSubjectID,
       i.StudentID,
       i.OldStudentID,
       i.SSID
  INTO #Missing2015
  FROM (
--> IN 2015 StudentTests BUT StudentID CHANGED
SELECT SchoolYear,
       TestSubjectID,
       t.StudentID
  FROM SAGE.StudentTests AS t
  JOIN [ACSDBPROD-1\ACS].SSID.dbo.RootSSIDs AS i
    ON t.StudentID = i.OldStudentID
 WHERE SchoolYear = 2015
   AND ParticipationCode NOT IN (204,304)
   AND ScaleScore IS NOT NULL
   AND IsFullAcademicYear = 'Y'
   AND SGP IS NULL
   AND ((GradeLevel >= 3 AND SubjectArea IN ('L','M'))
       OR (GradeLevel >= 4 AND SubjectArea = 'S'))
   AND CASE WHEN t.StudentID <> i.StudentID THEN 1 ELSE 0 END = 1
 UNION
--> IN 2015 reportable_tests BUT NOT FAY
SELECT school_year AS SchoolYear,
       test_subject_id AS TestSubjectID,
       r.student_id AS StudentID
  FROM SAGE.reportable_tests AS r
 WHERE school_year = 2015
   AND scale_score IS NOT NULL
   AND ParticipationCode NOT IN (204,304)
   AND full_academic_year = 'N'
 UNION
--> IN 2015 valid_tests 2015 BUT NOT IN reportable_tests
SELECT v.school_year AS SchoolYear,
       v.test_subject_id AS TestSubjectID,
       v.student_id AS StudentID
  FROM SAGE.valid_tests AS v
  LEFT JOIN SAGE.reportable_tests AS r
    ON v.school_year = r.school_year
       AND v.student_id = r.student_id
       AND v.test_subject_id = r.test_subject_id
 WHERE v.school_year = 2015
   AND v.scale_score IS NOT NULL
   AND v.ParticipationCode NOT IN (204,304)
   AND r.school_year IS NULL
   AND r.student_id IS NULL
   AND r.test_subject_id IS NULL
  ) AS sub
  JOIN [ACSDBPROD-1\ACS].SSID.dbo.RootSSIDs AS i
    ON sub.StudentID = i.OldStudentID
--> CHECK
SELECT * FROM #Missing2015

------ 2. UNION SET 2008-2009,2015 (N = 150,051; 1min:23sec) 
--> SUPPLEMENTAL SAGE 2015 (N = 68,262)
SELECT sub2.*
  FROM (
------ TIE BREAKER TO RESOLVE DUPLICATES
SELECT sub1.*,
   ROW_NUMBER() OVER (
       PARTITION BY SchoolYear, StudentID, CONTENT_AREA
       ORDER BY TestSubjectID
     ) AS preferred_score
  FROM (
------ RAW DATA SET
SELECT 'VALID_CASE' AS VALID_CASE,
       t.school_year AS SchoolYear,
       x.StudentID AS StudentID,
       t.test_subject_id AS TestSubjectID,
       c.test_subject AS TestSubject,    
       t.subject_area AS SubjectArea,
       NULL AS StudentGradeLevel, -- t.grade_level 
       p.grade_high AS HighestAppropriateTestGradeLevel,
       t.school_year AS YEAR,
       x.StudentID AS ID,
  CASE t.test_subject_id
       WHEN 313 THEN 'SEC_MATH_I'
       WHEN 314 THEN 'SEC_MATH_II'
       WHEN 315 THEN 'SEC_MATH_III'
       WHEN 505 THEN 'EARTH_SCIENCE'
       WHEN 506 THEN 'BIOLOGY'
       WHEN 507 THEN 'CHEMISTRY'
       WHEN 508 THEN 'PHYSICS'
       ELSE (
       CASE
       WHEN t.subject_area = 'L' THEN 'ELA'
       WHEN t.subject_area = 'M' AND t.test_subject_id NOT IN ('313','314','315') THEN 'MATHEMATICS'
       WHEN t.subject_area = 'S' AND t.test_subject_id NOT IN ('505','506','507','508') THEN 'SCIENCE' END
       )
   END AS CONTENT_AREA,
  CASE WHEN CAST(t.test_subject_id AS VARCHAR) IN ('313','314','315','505','506','507','508') THEN 'EOCT'
       WHEN p.grade_low = p.grade_high THEN CAST(p.grade_low AS VARCHAR)
       ELSE NULL -- t.grade_level
   END AS GRADE,
       t.scale_score AS SCALE_SCORE,
       t.proficiency_level AS ACHIEVEMENT_LEVEL,
       t.district_id AS DISTRICT_NUMBER,
       t.school_id AS SCHOOL_NUMBER,
       i.institution_name AS DISTRICT_NAME,
       s.school_name AS SCHOOL_NAME, 
       m.last_name AS LAST_NAME,
       m.first_name AS FIRST_NAME,
       x.ssid AS SSID,
       x.OldStudentID
  FROM #Missing2015 AS x
  JOIN SAGE.valid_tests AS t
    ON x.SchoolYear = t.school_year
       AND t.student_id IN (x.OldStudentID,x.StudentID)
       AND x.TestSubjectID = t.test_subject_id
  JOIN test_program p
    ON t.test_prog_id = p.test_prog_id
  JOIN ct_test_subjects AS c
    ON p.test_subject_id = c.test_subject_id
  JOIN student_master AS m
    ON x.StudentID = m.student_id
  JOIN v_be_school AS s
    ON t.district_id = s.district_id
       AND t.school_id = s.school_id
       AND t.school_number = s.school_nbr
  JOIN v_be_institution AS i
    ON s.district_id = i.institution_id
 WHERE t.school_year = 2015
   AND t.ParticipationCode NOT IN (204,304)
   AND t.scale_score IS NOT NULL
  ) AS sub1
  ) AS sub2
 WHERE preferred_score = 1
 UNION
--> SUPPLEMENTAL CRT 2008-2009 (N = 81,789)
SELECT sub2.*
  FROM (
------ TIE BREAKER TO RESOLVE DUPLICATES
SELECT sub1.*,
   ROW_NUMBER() OVER(
       PARTITION BY SchoolYear, StudentID, CONTENT_AREA
       ORDER BY SCALE_SCORE DESC, CASE WHEN StudentGradeLevel = HighestAppropriateTestGradeLevel THEN 1 ELSE 0 END DESC
     ) AS preferred_score
  FROM (
------ RAW DATA SET
SELECT 'VALID_CASE' AS VALID_CASE,
       t.school_year AS SchoolYear,
       x.StudentID AS StudentID,
       p.test_subject_id AS TestSubjectID,
       c.test_subject AS TestSubject,    
       p.subject_area AS SubjectArea,
       p.grade_high AS HighestAppropriateTestGradeLevel,
       CAST(e.grade_level AS TINYINT) AS StudentGradeLevel,
       t.school_year AS YEAR,
       x.StudentID AS ID,
  CASE p.test_subject_id
       WHEN 307 THEN 'PRE_ALGEBRA'
       WHEN 312 THEN 'PRE_ALGEBRA' -- Math 8
       WHEN 308 THEN 'GEOMETRY'
       WHEN 309 THEN 'ALGEBRA_I'
       WHEN 310 THEN 'ALGEBRA_II'
       WHEN 311 THEN 'ALGEBRA_II'
       WHEN 505 THEN 'EARTH_SCIENCE'
       WHEN 506 THEN 'BIOLOGY'
       WHEN 507 THEN 'CHEMISTRY'
       WHEN 508 THEN 'PHYSICS'
       ELSE (
       CASE
       WHEN p.subject_area = 'L' THEN 'ELA'
       WHEN p.subject_area = 'M' AND p.test_subject_id NOT IN ('307','312','308','309','310','311') THEN 'MATHEMATICS'
       WHEN p.subject_area = 'S' AND p.test_subject_id NOT IN ('505','506','507','508') THEN 'SCIENCE' END
       )
   END AS CONTENT_AREA,
  CASE WHEN CAST(p.test_subject_id AS VARCHAR) IN ('307','312','308','309','310','311','505','506','507','508') THEN 'EOCT'
       WHEN p.grade_low = p.grade_high THEN CAST(p.grade_low AS VARCHAR)
       ELSE CAST(e.grade_level AS VARCHAR)
   END AS GRADE,
       t.scaled_score AS SCALE_SCORE,
       t.proficiency AS ACHIEVEMENT_LEVEL,
       t.district_id AS DISTRICT_NUMBER,
       t.school_id AS SCHOOL_NUMBER,
       i.institution_name AS DISTRICT_NAME,
       s.school_name AS SCHOOL_NAME, 
       m.last_name AS LAST_NAME,
       m.first_name AS FIRST_NAME,
       x.ssid AS SSID,
       x.OldStudentID
  FROM student_test AS t
  JOIN test_program p
    ON t.test_prog_id = p.test_prog_id
  JOIN ct_test_subjects AS c
    ON p.test_subject_id = c.test_subject_id
  JOIN student_enrollment AS e
    ON t.school_year = e.school_year
       AND t.district_id = e.district_id
       AND t.school_id = e.school_id
       AND t.school_number = e.school_number
       AND t.student_id = e.student_id
       AND t.entry_date = e.entry_date
  JOIN [ACSDBPROD-1\ACS].SSID.dbo.RootSSIDs AS x
    ON t.student_id = x.OldStudentID
  JOIN student_master AS m
    ON t.student_id = m.student_id
  JOIN v_be_school AS s
    ON t.district_id = s.district_id
       AND t.school_id = s.school_id
       AND t.school_number = s.school_nbr
  JOIN v_be_institution AS i
    ON s.district_id = i.institution_id
 WHERE ((t.school_year = 2008 AND p.subject_area = 'M')
       OR t.school_year = 2009 AND e.full_academic_year = 'N')
   AND t.test_medium <> 'U'
   AND t.test_participation IN ('','1') AND t.test_non_participation = ''
   AND t.scaled_score BETWEEN 130 AND 199
   AND ((e.grade_level >= 3 AND p.subject_area IN ('L','M'))
    OR (e.grade_level >= 4 AND p.subject_area = 'S'))
   AND e.full_academic_year = 'N'
  ) AS sub1
  ) AS sub2
 WHERE preferred_score = 1

-------------------------------------------------------- 
------ 3. SAGE IDENTIFIERS 2014 (N = 75,988; 1min:12sec)
--> CHECK: Payson High (SchoolID = 827) Language Arts 11 (TestSubjectID = 110) N = 102
SELECT DISTINCT 
       SchoolYear,
       TestSubjectID,
       i.StudentID,
       i.OldStudentID
  FROM (
--> IN 2014 StudentTests BUT StudentID CHANGED
SELECT SchoolYear,
       TestSubjectID,
       t.StudentID
  FROM SAGE.StudentTests AS t
  JOIN [ACSDBPROD-1\ACS].SSID.dbo.RootSSIDs AS i
    ON t.StudentID = i.OldStudentID
 WHERE SchoolYear = 2014
   AND ParticipationCode NOT IN (204,304)
   AND ScaleScore IS NOT NULL
   AND IsFullAcademicYear = 'Y'
   AND SGP IS NULL
   AND ((GradeLevel >= 3 AND SubjectArea IN ('L','M'))
       OR (GradeLevel >= 4 AND SubjectArea = 'S'))
   AND CASE WHEN t.StudentID <> i.StudentID THEN 1 ELSE 0 END = 1 
 UNION
--> IN 2014 reportable_tests BUT NOT FAY
SELECT school_year AS SchoolYear,
       test_subject_id AS TestSubjectID,
       r.student_id AS StudentID
  FROM SAGE.reportable_tests AS r
 WHERE school_year = 2014
   AND scale_score IS NOT NULL
   AND ParticipationCode NOT IN (204,304)
   AND full_academic_year = 'N'
 UNION
--> IN 2014 valid_tests BUT NOT IN reportable_tests
SELECT v.school_year AS SchoolYear,
       v.test_subject_id AS TestSubjectID,
       v.student_id AS StudentID
  FROM SAGE.valid_tests AS v
  LEFT JOIN SAGE.reportable_tests AS r
    ON v.school_year = r.school_year
       AND v.student_id = r.student_id
       AND v.test_subject_id = r.test_subject_id
 WHERE v.school_year = 2014
   AND v.scale_score IS NOT NULL
   AND v.ParticipationCode NOT IN (204,304)
   AND r.school_year IS NULL
   AND r.student_id IS NULL
   AND r.test_subject_id IS NULL
  ) AS sub
  JOIN [ACSDBPROD-1\ACS].SSID.dbo.RootSSIDs AS i
    ON sub.StudentID = i.OldStudentID