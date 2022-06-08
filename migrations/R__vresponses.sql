CREATE OR REPLACE VIEW vresponses AS
SELECT
    *
FROM (
    SELECT
        vr.*,
        tq.topic_id
    FROM
        vresponseslong vr
    LEFT JOIN test_questions tq ON tq.test = vr.test
        AND split_part(vr.question_number::text, 'q', 2) = tq.question_index::text
    ORDER BY
        response_id,
        question_number) AS n
WHERE
    topic_id IS NOT NULL;

