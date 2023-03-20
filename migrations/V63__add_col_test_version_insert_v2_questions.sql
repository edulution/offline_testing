ALTER TABLE test_questions
    ADD COLUMN test_version varchar(10);

-- Set all blank test versions to v1
update responses set test_version = 'v1' where test_version is null;

-- Set test version of all questions initially to v1
update test_questions set test_version = 'v1';

-- Insert v2 test_question
-- create temp table for v2 config from query

drop table if exists temp_v2_questions;

create table temp_v2_questions as
select question_index,correct_answer_value,correct_answer_text,topic_id,test,course,module,test_version from test_questions where test in ('level_2_post','level_2_pre','level_2_sec_2','level_2_sec_3','level_3_post','level_3_pre','level_3_sec_2','level_3_sec_3','level_4_post','level_4_pre','level_4_sec_1','level_5_post','level_5_pre','level_5_sec_1');

update temp_v2_questions set test_version = 'v2';
-- Insert v3 test_questions

insert into test_questions(question_index,correct_answer_value,correct_answer_text,topic_id,test,course,module,test_version)
select * from temp_v2_questions;

drop table if exists temp_v2_questions;