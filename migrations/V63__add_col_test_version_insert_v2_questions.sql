ALTER TABLE test_questions
    ADD COLUMN test_version varchar(10);

-- Set all blank test versions to v1
UPDATE
    responses
SET
    test_version = 'v1'
WHERE
    test_version IS NULL;

-- Set test version of all questions initially to v1
UPDATE
    test_questions
SET
    test_version = 'v1';

-- Insert v2 test_question
-- create temp table for v2 config from query
DROP TABLE IF EXISTS temp_v2_questions;

CREATE TABLE temp_v2_questions AS
SELECT
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module,
    test_version
FROM
    test_questions
WHERE
    test IN ('level_2_post', 'level_2_pre', 'level_2_sec_2', 'level_2_sec_3', 'level_3_post', 'level_3_pre', 'level_3_sec_2', 'level_3_sec_3', 'level_4_post', 'level_4_pre', 'level_4_sec_1', 'level_5_post', 'level_5_pre', 'level_5_sec_1');

UPDATE
    temp_v2_questions
SET
    test_version = 'v2';

-- Insert v2 test_questions from temp table
INSERT INTO test_questions (
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module,
    test_version)
SELECT
    *
FROM
    temp_v2_questions;

-- Drop the temp table
DROP TABLE IF EXISTS temp_v2_questions;

