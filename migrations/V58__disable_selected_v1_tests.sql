-- Disable selected v1 tests to make room for v2 tests
UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_2_post'
    AND course = 'level_2'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_2_pre'
    AND course = 'level_2'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_2_sec_2'
    AND course = 'level_2'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_2_sec_3'
    AND course = 'level_2'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_3_post'
    AND course = 'level_3'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_3_pre'
    AND course = 'level_3'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_3_sec_2'
    AND course = 'level_3'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_3_sec_3'
    AND course = 'level_3'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_4_post'
    AND course = 'level_4'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_4_pre'
    AND course = 'level_4'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_4_sec_1'
    AND course = 'level_4'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_5_post'
    AND course = 'level_5'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_5_pre'
    AND course = 'level_5'
    AND module = 'numeracy';

UPDATE
    public.test_marks
SET
    test_seq = NULL
WHERE
    test_id = 'level_5_sec_1'
    AND course = 'level_5'
    AND module = 'numeracy';

