-- FUNCTION: public.calc_test_score(uuid)
DROP FUNCTION public.calc_test_score (uuid);

CREATE OR REPLACE FUNCTION public.calc_test_score (i_responseid uuid)
    RETURNS TABLE (
        user_id uuid,
        response_id uuid,
        test character varying,
        course character varying,
        module character varying,
        testmaxscore integer,
        test_pass_score numeric,
        score numeric,
        score_pct numeric,
        passed boolean)
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000
    AS $BODY$
BEGIN
    RETURN QUERY
    -- Use dynamic query to coalesce all q columms to get the score
    -- Join to test marks to get all other details about the test
    -- Calculate the score percent and derive boolean of whether test was passed or not
    EXECUTE format('SELECT *,
       score/testmaxscore AS score_pct,
       CASE
           WHEN score >= testmaxscore * test_pass_score THEN TRUE
           ELSE FALSE
       END AS passed
	FROM
  		(SELECT user_id,
          response_id,
          r.test,
          r.course,
          r.module,
          t.testmaxscore,
          t.test_pass_score,
          %s AS score
   	FROM responses r
   	LEFT JOIN test_marks t ON r.test::text = t.test_id::text
   	AND r.course::text = t.course::text
   	AND r.module::text = t.module::text
   	WHERE response_id = %s)resp_detail', string_agg(format('coalesce(%s::numeric, 0::numeric)', column_name), ' + '), quote_literal(i_responseid))
FROM
    information_schema.columns
    -- tighten query to account for mysterious replicants in the wrong schema
WHERE
    TABLE_NAME = 'responses'
        AND table_schema = 'public'
        AND COLUMN_NAME LIKE 'q%';
END;
$BODY$;