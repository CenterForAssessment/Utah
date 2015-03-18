------ Columns are in order as listed in sgpData_LONG documentation: 
------ http://cran.r-project.org/web/packages/SGPdata/SGPdata.pdf

-- FINALIZE DATA SET
SELECT sub2.*
  FROM (
-- CONSTRUCT TIE BREAKER TO RESOLVE DUPLICATES
SELECT sub1.*,
   ROW_NUMBER() OVER(
       PARTITION BY school_year, student_id, CONTENT_AREA
       ORDER BY scale_score DESC, CASE WHEN grade_level = grade_high THEN 1 ELSE 0 END DESC
       -- Prefer the higher score, if the scores are the same, prefer the test taken at the student's grade level
  ) AS row_nbr
  FROM (
-- CONSTRUCT RAW DATA SET
SELECT t.student_id AS ID,
       m.last_name AS LAST_NAME,
       m.first_name AS FIRST_NAME,
    -- Test Score
  CASE t.test_subject_id -- Course-based tests
       WHEN 313 THEN 'SEC_MATH_I' -- New for 2014
       WHEN 314 THEN 'SEC_MATH_II' -- New for 2014
       WHEN 315 THEN 'SEC_MATH_III' -- New for 2014
       WHEN 505 THEN 'EARTH_SCIENCE'
       WHEN 506 THEN 'BIOLOGY'
       WHEN 507 THEN 'CHEMISTRY'
       WHEN 508 THEN 'PHYSICS'
       ELSE (CASE -- Grade-based tests
       WHEN t.subject_area = 'L'
       AND t.test_subject_id NOT IN ('313','314','315','505','506','507','508') THEN 'ELA'
       WHEN t.subject_area = 'M'
       AND t.test_subject_id NOT IN ('313','314','315','505','506','507','508') THEN 'MATHEMATICS'
       WHEN t.subject_area = 'S'
       AND t.test_subject_id NOT IN ('313','314','315','505','506','507','508') THEN 'SCIENCE'
  END) END AS CONTENT_AREA,
       2014 AS YEAR,
  CASE WHEN CAST(t.test_subject_id AS VARCHAR) IN ('313','314','315','505','506','507','508') THEN 'EOCT'
       WHEN p.grade_low = p.grade_high THEN CAST(p.grade_low AS VARCHAR)
       ELSE CAST(e.grade_level AS VARCHAR)
   END AS GRADE,
       t.scale_score AS SCALE_SCORE,
       t.proficiency_level AS ACHIEVEMENT_LEVEL, -- Transform to factor data type in Utah_SGP_2014.R
    -- Demographics
       m.gender AS GENDER,
  CASE e.race_merged 
       WHEN 'A' THEN 'Asian'
       WHEN 'B' THEN 'Black'
       WHEN 'C' THEN 'White'
       WHEN 'H' THEN 'Hispanic'
       WHEN 'I' THEN 'American Indian'
       WHEN 'M' THEN 'More Than One Race'
       WHEN 'P' THEN 'Pacific Islander'
       WHEN 'U' THEN 'Unknown'
   END AS ETHNICITY,
  CASE WHEN e.low_income = 1 THEN 'Free Reduced Lunch: Yes' ELSE 'Free Reduced Lunch: No'
   END AS FRL_STATUS,
  CASE WHEN e.ell_status IN ('F','M','O','Y') THEN 'ELL: Yes' ELSE 'ELL: No'
   END AS ELL_STATUS,
  CASE WHEN e.special_ed = 'Y' THEN 'IEP: Yes' ELSE 'IEP: Yes'
   END AS IEP_STATUS,
       NULL AS GT_STATUS,
    -- School
       e.school_id AS SCHOOL_NUMBER,
       i2.institution_name AS SCHOOL_NAME, 
  CASE s.grade_level_summary
       WHEN 'ELEM' THEN 'E'
       WHEN 'MID'  THEN 'M'
       WHEN 'HIGH' THEN 'H'
       WHEN 'K12'  THEN 'H'
       ELSE NULL
   END AS EMH_LEVEL,
       e.district_id AS DISTRICT_NUMBER,
       i1.institution_name AS DISTRICT_NAME,
    -- Already limited to school FAY:
      'Enrolled School: Yes' AS SCHOOL_ENROLLMENT_STATUS,
      'Enrolled District: Yes' AS DISTRICT_ENROLLMENT_STATUS,
      'Enrolled State: Yes' AS STATE_ENROLLMENT_STATUS,
      'VALID_CASE' AS VALID_CASE, -- Only valid cases are loaded
    -- Additional Variables
       cts.test_subject, -- Combines CONTENT_AREA and GRADE information
    -- Primary Key (for matching SGP 2014 output to SAGE reportable test data)
       t.school_year,
       t.student_id,
       t.test_subject_id,
       e.grade_level,
       p.grade_high
  FROM sage.sage_reportable_tests AS t
  JOIN ct_test_subjects AS cts
    ON t.test_subject_id = cts.test_subject_id
  JOIN test_program p
    ON t.test_subject_id = p.test_subject_id AND p.school_year = 2014
       -- sage_reportable_tests attributes wrong test_prog_id to tests based only on subject area match
  JOIN student_enrollment AS e
    ON t.school_year = e.school_year
       AND t.district_id = e.district_id
       AND t.school_id = e.school_id
       AND t.school_number = e.school_number
       AND t.student_id = e.student_id
       AND t.school_entry_date = e.entry_date
  JOIN student_master AS m
    ON e.student_id = m.student_id
  JOIN v_be_institution AS i1
    ON e.district_id = i1.institution_id
  JOIN v_be_institution AS i2
    ON e.school_id = i2.institution_id
  JOIN v_be_school AS s
    ON t.district_id = s.district_id
       AND t.school_id = s.school_id
       AND t.school_number = s.school_nbr
 WHERE t.school_year = 2014
   AND t.test_participation_code IN (200,201,300) -- Standard participation, accommodated
   AND t.scale_score IS NOT NULL
   AND e.full_academic_year = 'Y' -- School level
  ) AS sub1
  ) AS sub2
 WHERE row_nbr = 1