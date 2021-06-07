-- Add course family to course

ALTER TABLE course ADD COLUMN course_family text;


UPDATE course
SET course_family = 'Alpha'
WHERE course LIKE 'alpha_%';


UPDATE course
SET course_family = 'PreAlpha'
WHERE course = 'prealpha';


UPDATE course
SET course_family = 'Bravo'
WHERE course LIKE 'bravo_%';


UPDATE course
SET course_family = 'Level 1'
WHERE course = 'level_1';


UPDATE course
SET course_family = 'Level 2'
WHERE course = 'level_2';


UPDATE course
SET course_family = 'Level 3'
WHERE course = 'level_3';


UPDATE course
SET course_family = 'Level 4'
WHERE course = 'level_4';


UPDATE course
SET course_family = 'Level 5'
WHERE course = 'level_5';


UPDATE course
SET course_family = 'Zambia Grade 7 Revision'
WHERE course = 'zm_gr7_revision';

