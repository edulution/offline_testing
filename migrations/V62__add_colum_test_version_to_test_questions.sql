ALTER TABLE test_questions
    ADD COLUMN test_version varchar(10);

-- Set all blank test versions to v1
update responses set test_version = 'v1' where test_version is null;

-- Set test version of all questions initially to v1
update test_questions set test_version = 'v1';

-- Insert v2 test_questions

-- Insert v3 test_questions

