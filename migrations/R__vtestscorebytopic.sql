-- View: public.vtestscorebytopic
-- DROP VIEW public.vtestscorebytopic;
CREATE OR REPLACE VIEW public.vtestscorebytopic AS
SELECT
    max(u.username::text) AS username,
    max(tm.test_name::text) AS test_name,
    vr.response_id,
    vr.user_id,
    tq.topic_id,
    max(tt.topic_name::text) AS topic_name,
    max(tt.channel_name::text) AS channel_name,
    max(tt.channel_id::text) AS channel_id,
    max(vr.course::text) AS course,
    max(vr.module::text) AS module,
    max(vr.test_date::text) AS test_date,
    avg(answer::numeric) AS answer
FROM
    vresponses vr
    LEFT JOIN test_questions tq ON tq.course::text = vr.course::text
        AND tq.module::text = vr.module::text
        AND tq.test::text = vr.test::text
        AND tq.question_index::text = split_part(vr.question_number, 'q'::text, 2)
    LEFT JOIN test_topics tt ON tq.topic_id = tt.topic_id
    LEFT JOIN users u ON u.user_id = vr.user_id
    LEFT JOIN test_marks tm ON tm.test_id::text = vr.test::text
WHERE
    tq.topic_id IS NOT NULL
GROUP BY
    vr.response_id,
    vr.user_id,
    tq.topic_id;

