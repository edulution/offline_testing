CREATE OR REPLACE VIEW vrecommended_test
 AS
 SELECT user_id,
    get_recommended_test(user_id, 'numeracy') AS recommended_test
   FROM users;