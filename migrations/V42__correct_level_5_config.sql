/*Level 5 tests were out of sequence
Update the sequence of each to correct this*/

UPDATE test_marks
SET test_seq = 6
WHERE test_id = 'level_5_post'
  AND course = 'level_5'
  AND module = 'numeracy';

UPDATE test_marks
SET test_seq = 1
WHERE test_id = 'level_5_pre'
  AND course = 'level_5'
  AND module = 'numeracy';


UPDATE test_marks
SET test_seq = 2
WHERE test_id = 'level_5_sec_1'
  AND course = 'level_5'
  AND module = 'numeracy';


UPDATE test_marks
SET test_seq = 3
WHERE test_id = 'level_5_sec_2'
  AND course = 'level_5'
  AND module = 'numeracy';


UPDATE test_marks
SET test_seq = 4
WHERE test_id = 'level_5_sec_3'
  AND course = 'level_5'
  AND module = 'numeracy';


UPDATE test_marks
SET test_seq = 5
WHERE test_id = 'level_5_sec_4'
  AND course = 'level_5'
  AND module = 'numeracy';

