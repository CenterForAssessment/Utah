------ Columns are in order as listed in sgpData_LONG documentation: 
------ http://cran.r-project.org/web/packages/SGPdata/SGPdata.pdf
SELECT m.ssid AS ID, -- Uses statewide student identifier for constructing locally interpretable name for student profile
       m.last_name AS LAST_NAME,
       m.first_name AS FIRST_NAME,
    -- Test Score
  CASE test.test_subject_id -- Course-based tests
       WHEN 307 THEN 'PRE_ALGEBRA'
       WHEN 308 THEN 'GEOMETRY'
       WHEN 309 THEN 'ALGEBRA_I'
       WHEN 310 THEN 'ALGEBRA_II'
       WHEN 311 THEN 'ALGEBRA_II'
       WHEN 313 THEN 'SEC_MATH_I' -- New for 2014
       WHEN 314 THEN 'SEC_MATH_II' -- New for 2014
       WHEN 315 THEN 'SEC_MATH_III' -- New for 2014
       WHEN 505 THEN 'EARTH_SCIENCE'
       WHEN 506 THEN 'BIOLOGY'
       WHEN 507 THEN 'CHEMISTRY'
       WHEN 508 THEN 'PHYSICS'
 ELSE (CASE -- Grade-based tests
       WHEN test.subject_area = 'L'
       AND test.test_subject_id NOT IN ('307','308','309','310','311','313','314','315','505','506','507','508') THEN 'ELA'
       WHEN test.subject_area = 'M'
       AND test.test_subject_id NOT IN ('307','308','309','310','311','313','314','315','505','506','507','508') THEN 'MATHEMATICS'
       WHEN test.subject_area = 'S'
       AND test.test_subject_id NOT IN ('307','308','309','310','311','313','314','315','505','506','507','508') THEN 'SCIENCE'
  END) END AS CONTENT_AREA,
       CAST(test.school_year AS INT) AS YEAR,
  CASE WHEN CAST(test.test_subject_id AS VARCHAR) IN ('307','308','309','310','311','313','314','315','505','506','507','508') THEN 'EOCT'
       WHEN test.grade_low = test.grade_high THEN CAST(test.grade_low AS VARCHAR)
       ELSE CAST(e.grade_level AS VARCHAR)
   END AS GRADE,
       test.scale_score AS SCALE_SCORE,
       test.proficiency_level AS ACHIEVEMENT_LEVEL, -- Transform to factor data type in Utah_SGP_2014.R
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
      'VALID CASE' AS VALID_CASE, -- Only valid cases are loaded
    -- Additional Variables
COALESCE (
       CASE WHEN test.student_test_id IS NOT NULL THEN 'student_test' ELSE NULL END,
       CASE WHEN test.sage_result_id IS NOT NULL THEN 'sage_reportable_tests' ELSE NULL END)
  ) AS source_table,
COALESCE (
       CASE WHEN test.student_test_id IS NOT NULL THEN test.student_test_id ELSE NULL END,
       CASE WHEN test.sage_result_id IS NOT NULL THEN test.sage_result_id ELSE NULL END)
  ) AS source_row_id,
       test.assessment_series, -- {CRT, NWEA, SAGE}
       test.test_name, -- Combines CONTENT_AREA and GRADE information
    -- Primary Key (for matching SGP 2014 output to SAGE test data)
       test.school_year,
       test.student_id,
       test.test_subject_id
  FROM (
  
------ OLD STUDENT TEST (student_test)
SELECT school_year, subject_area, test_name, COUNT(*) FROM (
SELECT t.student_test_id,
       NULL AS sage_result_id,
       t.school_year,
       t.district_id,
       t.school_id,
       t.school_number AS school_nbr,
       t.student_id,
       t.entry_date,
       p.subject_area,
       cts.test_subject AS test_name,
       t.scaled_score AS scale_score,
       t.proficiency AS proficiency_level,
       p.grade_low,
       p.grade_high,
       p.test_subject_id,
  CASE t.test_medium WHEN 'NW' THEN 'NWEA' ELSE 'CRT' END AS assessment_series,
  CASE WHEN (
   ROW_NUMBER() OVER ( -- To eliminate duplicate test rows
       PARTITION BY t.school_year, t.student_id, p.test_subject_id
       ORDER BY t.scaled_score DESC, t.student_test_id ASC) -- Higher scale score, otherwise random tie breaker
       ) = 1
       THEN 1 ELSE 0
   END AS unique_case,
       h.overall_response_count
  FROM student_test AS t
  JOIN test_program AS p ON t.test_prog_id = p.test_prog_id
  JOIN ct_test_subjects AS cts ON p.test_subject_id = cts.test_subject_id
  LEFT JOIN crt8_raw_data_history h  	
    ON t.filename = h.filename	
   AND t.line_number = h.line_number	
   AND t.school_year = h.school_year
 WHERE t.school_year BETWEEN 2009 AND 2013
   AND t.test_medium <> 'U'
   AND t.test_participation IN ('','1') AND t.test_non_participation = '' -- Standard or accommodated participation
   AND t.scaled_score IS NOT NULL AND t.scaled_score <> 0 -- Must have a valid score
   AND (h.overall_response_count IS NULL OR h.overall_response_count > 0) -- Ensure that minimum score was not arbitrarily assigned
  ) AS sub
 GROUP BY school_year, subject_area, test_name ORDER BY school_year, subject_area, test_name
 UNION ALL
 
------ NEW STUDENT TEST (sage_reportable_tests ["Staging 2"])
SELECT NULL AS t.student_test_id,
       t.sage_result_id,
       t.school_year,
       t.district_id,
       t.school_id,
       t.school_nbr,
       t.student_id,
       t.school_entry_date AS entry_date,
       p.subject_area,
       cts.test_subject AS test_name,
       t.scale_score,
       t.proficiency_level,
       p.grade_low,
       p.grade_high,
       p.test_subject_id,
       'SAGE' AS assessment_series,
       1 AS unique_case,
       NULL AS overall_response_count
  FROM sage_reportable_tests AS t
  JOIN test_program AS p ON t.test_prog_id = p.test_prog_id
  JOIN ct_test_subjects AS cts ON p.test_subject_id = cts.test_subject_id	
 WHERE t.school_year = 2014
   AND t.test_participation_code IN (200,201)
   AND t.scale_score IS NOT NULL
  
  ) AS test -- UNION of the old and new student test tables
    -- Add demographics
  JOIN student_enrollment AS e
    ON test.school_year = e.school_year
       AND test.district_id = e.district_id
       AND test.school_id = e.school_id
       AND test.school_nbr = e.school_number
       AND test.student_id = e.student_id
       AND test.entry_date = e.entry_date
  JOIN student_master AS m ON e.student_id = m.student_id
    -- Add school info
  JOIN v_be_institution AS i1 ON e.district_id = i1.institution_id
  JOIN v_be_institution AS i2 ON e.school_id = i2.institution_id
  JOIN v_be_school AS s
    ON test.district_id = s.district_id
       AND test.school_id = s.school_id
       AND test.school_nbr = s.school_nbr
 WHERE test.unique_case = 1
   AND e.grade_level BETWEEN 3 AND 12
   AND e.full_academic_year = 'Y' -- School level (implies LEA and state levels)