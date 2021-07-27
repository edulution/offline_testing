CREATE OR REPLACE FUNCTION calc_test_score (
	i_responseid uuid
	)
RETURNS TABLE(
	response_id uuid,
	score NUMERIC
	) as $$
BEGIN
	RETURN QUERY
	-- Use dynamic query to coalesce and sum all of the q columns to derive the score
    EXECUTE format('SELECT response_id, %s AS score FROM responses WHERE response_id = %s', string_agg(format('coalesce(%s::numeric, 0::numeric)', column_name), ' + '),quote_literal(i_responseid))
    from information_schema.columns
    where table_name = 'responses'
    and column_name like 'q%';
END;$$
LANGUAGE plpgsql VOLATILE


