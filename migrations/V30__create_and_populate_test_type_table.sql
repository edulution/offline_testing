/*Create a config table for test types*/
CREATE TABLE IF NOT EXISTS test_type
(
    test_type character varying(5) COLLATE pg_catalog."default" NOT NULL,
    description character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT bltest_type_pkey PRIMARY KEY (test_type)
);

/*Populate the table with the current test types available*/
INSERT INTO test_type( test_type, description)
VALUES ('TST',
        'Pre/Post test');


INSERT INTO test_type( test_type, description)
VALUES ('SEC',
        'Sectional Test (depreciated)');


INSERT INTO test_type( test_type, description)
VALUES ('TLT',
        'Testlet');


INSERT INTO test_type( test_type, description)
VALUES ('EVL',
        'Evaluation');


INSERT INTO test_type( test_type, description)
VALUES ('EPR',
        'Exam preparation');

 -- Add test type column to bltest table

ALTER TABLE test_marks ADD COLUMN test_type varchar(5);

 -- Add foreign key constraint between bltest_type and bltest

ALTER TABLE test_marks ADD CONSTRAINT test_type_fk
FOREIGN KEY (test_type) REFERENCES test_type(test_type);

 -- Set all grade 7 revision tests to exam preparation

UPDATE test_marks
SET test_type = 'EPR'
WHERE test_id LIKE 'grade7%';

 -- Set all new testlets to type testlets

UPDATE test_marks
SET test_type = 'TLT'
WHERE test_id LIKE 'level_%_sec_%';

 -- Set all old sectional tests to type sectional test

UPDATE test_marks
SET test_type = 'SEC'
WHERE test_id LIKE 'sec_%';

 -- Set all Brombacher evaluations to type EVL

UPDATE test_marks
SET test_type = 'EVL'
WHERE test_id LIKE 'brom_%';

 -- Set all the rest to pre/post tests

UPDATE test_marks
SET test_type = 'TST'
WHERE test_type IS NULL;