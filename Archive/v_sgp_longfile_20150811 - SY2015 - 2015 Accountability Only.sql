--ALTER VIEW v_sgp_longfile AS
------ SGP 2015 LONGFILE
SELECT VALID_CASE,
       SchoolYear,
       StudentID,
       TestSubjectID,
       TestSubject,
       SubjectArea,
       StudentGradeLevel,
       YEAR,
       ID, -- student_id
       CONTENT_AREA,
       GRADE,
       SCALE_SCORE,
       ACHIEVEMENT_LEVEL,
       DISTRICT_NUMBER,
       SCHOOL_NUMBER,
       DISTRICT_NAME,
       SCHOOL_NAME,
       LAST_NAME,
       FIRST_NAME,
       SSID -- Use in construction of individual student report (ISR) file name
  FROM (
---------------------------------
------ SAGE 2015 REPORTABLE TESTS [COUNT(*) = 1,065,488 (0min:14sec)]
SELECT sub2.*
  FROM (
------ TIE BREAKER TO RESOLVE DUPLICATES
SELECT sub1.*,
   ROW_NUMBER() OVER (
       PARTITION BY SchoolYear, StudentID, CONTENT_AREA
       ORDER BY TestSubjectID -- Prefer the score associated with the more advanced course
     ) AS preferred_score
  FROM (
------ RAW DATA SET
SELECT 'VALID_CASE' AS VALID_CASE,
       t.school_year AS SchoolYear,
       r.StudentID AS StudentID,
       t.test_subject_id AS TestSubjectID,
       c.test_subject AS TestSubject,    
       t.subject_area AS SubjectArea,
       t.grade_level AS StudentGradeLevel,
       NULL AS HighestAppropriateTestGradeLevel,
       t.school_year AS YEAR,
       r.StudentID AS ID,
  CASE t.test_subject_id
       WHEN 312 THEN 'PRE_ALGEBRA' -- Math 8
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
       WHEN t.subject_area = 'M' AND t.test_subject_id NOT IN ('312','313','314','315') THEN 'MATHEMATICS'
       WHEN t.subject_area = 'S' AND t.test_subject_id NOT IN ('505','506','507','508') THEN 'SCIENCE' END
       )
   END AS CONTENT_AREA,
  CASE WHEN CAST(t.test_subject_id AS VARCHAR) IN ('312','313','314','315','505','506','507','508') THEN 'EOCT'
       WHEN p.grade_low = p.grade_high THEN CAST(p.grade_low AS VARCHAR)
       ELSE CAST(t.grade_level AS VARCHAR)
   END AS GRADE,
       t.scale_score AS SCALE_SCORE,
       t.proficiency_level AS ACHIEVEMENT_LEVEL,
       t.district_id AS DISTRICT_NUMBER,
       t.school_id AS SCHOOL_NUMBER,
       i.institution_name AS DISTRICT_NAME,
       s.school_name AS SCHOOL_NAME, 
       m.last_name AS LAST_NAME,
       m.first_name AS FIRST_NAME,
       r.ssid AS SSID
  FROM SAGE.reportable_tests AS t
  JOIN test_program p
    ON t.test_prog_id = p.test_prog_id
  JOIN ct_test_subjects AS c
    ON p.test_subject_id = c.test_subject_id
  JOIN RootSSIDs AS r
    ON t.student_id = r.OldStudentID
  JOIN student_master AS m
    ON r.StudentID = m.student_id
  JOIN v_be_school AS s
    ON t.district_id = s.district_id
       AND t.school_id = s.school_id
       AND t.school_number = s.school_nbr
  JOIN v_be_institution AS i
    ON s.district_id = i.institution_id
 WHERE t.school_year = 2015
   AND t.ParticipationCode NOT IN (204,304) -- Not excluded from testing by parent
   AND t.scale_score IS NOT NULL -- Scale score is available
   AND t.full_academic_year = 'Y' -- Enrolled for full academic year in school
  ) AS sub1
  ) AS sub2
 WHERE preferred_score = 1
 UNION ALL
----------------------------
------ SAGE 2014 VALID TESTS [COUNT(*) = 1,095,347 (0min:24sec)]
SELECT sub2.* 
  FROM (
------ TIE BREAKER TO RESOLVE DUPLICATES
SELECT sub1.*,
   ROW_NUMBER() OVER (
       PARTITION BY StudentID, CONTENT_AREA
       ORDER BY TestSubjectID -- Prefer the score associated with the more advanced course
  ) AS preferred_score
  FROM (
------ RAW DATA SET
SELECT 'VALID_CASE' AS VALID_CASE,
       t.school_year AS SchoolYear,
       t.student_id AS StudentID,
       t.test_subject_id AS TestSubjectID,
       c.test_subject AS TestSubject,    
       t.subject_area AS SubjectArea,
       e.grade_level AS StudentGradeLevel,
       NULL AS HighestAppropriateTestGradeLevel,
       t.school_year AS YEAR,
       r.StudentID AS ID,
  CASE p.test_subject_id
       WHEN 312 THEN 'PRE_ALGEBRA' -- Math 8
       WHEN 313 THEN 'SEC_MATH_I'
       WHEN 314 THEN 'SEC_MATH_II'
       WHEN 315 THEN 'SEC_MATH_III'
       WHEN 505 THEN 'EARTH_SCIENCE'
       WHEN 506 THEN 'BIOLOGY'
       WHEN 507 THEN 'CHEMISTRY'
       WHEN 508 THEN 'PHYSICS'
       ELSE (
       CASE
       WHEN p.subject_area = 'L' THEN 'ELA'
       WHEN p.subject_area = 'M' AND p.test_subject_id NOT IN ('312','313','314','315') THEN 'MATHEMATICS'
       WHEN p.subject_area = 'S' AND p.test_subject_id NOT IN ('505','506','507','508') THEN 'SCIENCE' END
       )
   END AS CONTENT_AREA,
  CASE WHEN CAST(p.test_subject_id AS VARCHAR) IN ('312','313','314','315','505','506','507','508') THEN 'EOCT'
       WHEN p.grade_low = p.grade_high THEN CAST(p.grade_low AS VARCHAR)
       ELSE CAST(e.grade_level AS VARCHAR)
   END AS GRADE,
       t.scale_score AS SCALE_SCORE,
       t.proficiency_level AS ACHIEVEMENT_LEVEL,
       t.district_id AS DISTRICT_NUMBER,
       t.school_id AS SCHOOL_NUMBER,
       i.institution_name AS DISTRICT_NAME,
       s.school_name AS SCHOOL_NAME, 
       m.last_name AS LAST_NAME,
       m.first_name AS FIRST_NAME,
       r.ssid AS SSID
  FROM SAGE.valid_tests AS t
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
  JOIN RootSSIDs AS r
    ON t.student_id = r.OldStudentID
  JOIN student_master AS m
    ON r.StudentID = m.student_id
  JOIN v_be_school AS s
    ON t.district_id = s.district_id
       AND t.school_id = s.school_id
       AND t.school_number = s.school_nbr
  JOIN v_be_institution AS i
    ON s.district_id = i.institution_id
 WHERE t.school_year = 2014
   AND t.ParticipationCode <> 204
   AND t.scale_score IS NOT NULL
  ) AS sub1
  ) AS sub2
 WHERE preferred_score = 1 
 UNION ALL
--------------------
------ CRT 2010-2013 [COUNT(*) = 4,170,653 (1min:55sec)]
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
       r.StudentID AS StudentID,
       p.test_subject_id AS TestSubjectID,
       c.test_subject AS TestSubject,    
       p.subject_area AS SubjectArea,
       p.grade_high AS HighestAppropriateTestGradeLevel,
       CAST(e.grade_level AS TINYINT) AS StudentGradeLevel,
       t.school_year AS YEAR,
       t.student_id AS ID,
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
       r.ssid AS SSID
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
  JOIN RootSSIDs AS r
    ON t.student_id = r.OldStudentID
  JOIN student_master AS m
    ON r.StudentID = m.student_id
  JOIN v_be_school AS s
    ON t.district_id = s.district_id
       AND t.school_id = s.school_id
       AND t.school_number = s.school_nbr
  JOIN v_be_institution AS i
    ON s.district_id = i.institution_id
 WHERE t.school_year BETWEEN 2010 AND 2013
   AND t.test_medium <> 'U'
   AND t.test_participation IN ('','1') AND t.test_non_participation = ''
   AND t.scaled_score BETWEEN 130 AND 199
   AND ((e.grade_level >= 3 AND p.subject_area IN ('L','M'))
    OR (e.grade_level >= 4 AND p.subject_area = 'S'))
  ) AS sub1
  ) AS sub2
 WHERE preferred_score = 1 
  ) AS sub3