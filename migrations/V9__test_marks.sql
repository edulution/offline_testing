/*Create test marks table*/
/*Primary key on (test_id,course,module)*/
CREATE TABLE test_marks (
    test_id varchar,
    test_name varchar,
    course varchar,
    module varchar,
    testmaxscore integer,
    test_pass_score numeric(3, 2),
    channel_id uuid,
    PRIMARY KEY(test_id, course, module)
);