/*Function to get count of learners in each level present in a class*/
CREATE OR REPLACE FUNCTION get_learner_count(
	grade character varying)
    RETURNS TABLE(group_name character varying, class_name character varying, total_learners bigint) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY 
        SELECT CASE WHEN r.group_name IS null THEN 'Ungrouped' ELSE r.group_name END AS group_name,r.class_name, r.total_learners FROM 
		(SELECT u.group_name,u.class_name,COUNT (DISTINCT(u.user_id)) total_learners FROM users u GROUP BY u.group_name, u.class_name) r
			WHERE r.class_name = grade;
END; 
$BODY$;