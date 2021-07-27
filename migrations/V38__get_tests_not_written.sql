CREATE OR REPLACE FUNCTION get_tests_not_written(
  i_userid uuid,
  i_module varchar
  )
  
RETURNS TABLE(
  user_id uuid,
  test_id varchar,
  test_name varchar,
  course varchar,
  module varchar,
  testmaxscore integer,
  test_pass_score numeric,
  channel_id uuid,
  test_type varchar,
  test_seq integer
  )
language plpgsql
AS $$
BEGIN
RETURN QUERY
  SELECT *
  FROM
    (SELECT i_userid AS user_id)u
  CROSS JOIN
    (SELECT *
     FROM test_marks
     WHERE test_marks.test_seq IS NOT NULL
       AND test_marks.module = i_module)tm
  WHERE NOT EXISTS
      (SELECT 1
       FROM responses v
       WHERE u.user_id = v.user_id
         AND tm.test_id = v.test
         AND tm.course = v.course
         AND tm.module = v.module);
END;$$