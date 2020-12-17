# Drop constraint on test_marks table
ALTER TABLE test_marks
DROP CONSTRAINT fk_course_test;

# Update course to zm_gr7_revision in test_marks and course table
# Update channel_id to id for grade 7 revision
UPDATE course
SET course = 'zm_gr7_revision',
             channel_id = '8d368058656544e2b7fe62eb2a632698'
WHERE course = 'grade7_revision'
  AND module = 'numeracy';

# Update course to zm_gr7_revision in test_marks table and add channel_id
UPDATE test_marks
SET course = 'zm_gr7_revision',
             channel_id = '8d368058656544e2b7fe62eb2a632698'
WHERE course = 'grade7_revision'
  AND module = 'numeracy';

# Update all existing responses to grade 7 tests to zm_gr7_revision
UPDATE responses
SET course = 'zm_gr7_revision'
WHERE course = 'grade7_revision';

# Recreate constraint on test marks
ALTER TABLE test_marks ADD CONSTRAINT fk_course_test
FOREIGN KEY (course,
             module) REFERENCES public.course (course, module) MATCH SIMPLE ON
UPDATE NO ACTION ON
DELETE NO ACTION;

# Delete any reference to old course if it exists
DELETE
FROM course
WHERE course = 'grade7_revision';