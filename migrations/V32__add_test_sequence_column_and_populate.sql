/*Create a column for test sequence in test_marks table
Numeric representation of the sequence the tests should be taken
*/
ALTER TABLE test_marks ADD COLUMN test_seq integer;

/*Update test sequence for each test*/
UPDATE test_marks
SET test_seq=2
WHERE test_id = 'level_1_sec_1';


UPDATE test_marks
SET test_seq=3
WHERE test_id = 'level_1_sec_2';


UPDATE test_marks
SET test_seq=4
WHERE test_id = 'level_1_sec_3';


UPDATE test_marks
SET test_seq=5
WHERE test_id = 'level_1_sec_4';


UPDATE test_marks
SET test_seq=2
WHERE test_id = 'level_2_sec_1';


UPDATE test_marks
SET test_seq=3
WHERE test_id = 'level_2_sec_2';


UPDATE test_marks
SET test_seq=4
WHERE test_id = 'level_2_sec_3';


UPDATE test_marks
SET test_seq=5
WHERE test_id = 'level_2_sec_4';


UPDATE test_marks
SET test_seq=2
WHERE test_id = 'level_3_sec_1';


UPDATE test_marks
SET test_seq=3
WHERE test_id = 'level_3_sec_2';


UPDATE test_marks
SET test_seq=4
WHERE test_id = 'level_3_sec_3';


UPDATE test_marks
SET test_seq=5
WHERE test_id = 'level_3_sec_4';


UPDATE test_marks
SET test_seq=2
WHERE test_id = 'level_4_sec_1';


UPDATE test_marks
SET test_seq=3
WHERE test_id = 'level_4_sec_2';


UPDATE test_marks
SET test_seq=4
WHERE test_id = 'level_4_sec_3';


UPDATE test_marks
SET test_seq=2
WHERE test_id = 'level_5_sec_4';


UPDATE test_marks
SET test_seq=5
WHERE test_id = 'level_4_sec_4';


UPDATE test_marks
SET test_seq=3
WHERE test_id = 'level_5_sec_1';


UPDATE test_marks
SET test_seq=4
WHERE test_id = 'level_5_sec_2';


UPDATE test_marks
SET test_seq=5
WHERE test_id = 'level_5_sec_3';


UPDATE test_marks
SET test_seq=1
WHERE test_id = 'level_1_pre';


UPDATE test_marks
SET test_seq=1
WHERE test_id = 'level_2_pre';


UPDATE test_marks
SET test_seq=1
WHERE test_id = 'level_3_pre';


UPDATE test_marks
SET test_seq=1
WHERE test_id = 'level_4_pre';


UPDATE test_marks
SET test_seq=1
WHERE test_id = 'level_5_pre';


UPDATE test_marks
SET test_seq=6
WHERE test_id = 'level_1_post';


UPDATE test_marks
SET test_seq=6
WHERE test_id = 'level_2_post';


UPDATE test_marks
SET test_seq=6
WHERE test_id = 'level_3_post';


UPDATE test_marks
SET test_seq=6
WHERE test_id = 'level_4_post';


UPDATE test_marks
SET test_seq=6
WHERE test_id = 'level_5_post';