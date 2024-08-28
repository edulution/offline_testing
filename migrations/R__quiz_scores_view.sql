create or replace view vquizscores as
WITH quiz_scores_raw AS (
    SELECT
        response_id,
        user_id,
        test,
        course,
        module,
        test_date,
        (COALESCE(q1::int, 0) + COALESCE(q2::int, 0) + COALESCE(q3::int, 0) + COALESCE(q4::int, 0) + COALESCE(q5::int, 0) + COALESCE(q6::int, 0) + COALESCE(q7::int, 0) + COALESCE(q8::int, 0) + COALESCE(q9::int, 0) + COALESCE(q10::int, 0) + COALESCE(q11::int, 0) + COALESCE(q12::int, 0) + COALESCE(q13::int, 0) + COALESCE(q14::int, 0) + COALESCE(q15::int, 0) + COALESCE(q16::int, 0) + COALESCE(q17::int, 0) + COALESCE(q18::int, 0) + COALESCE(q19::int, 0) + COALESCE(q20::int, 0) + COALESCE(q21::int, 0) + COALESCE(q22::int, 0) + COALESCE(q23::int, 0) + COALESCE(q24::int, 0) + COALESCE(q25::int, 0) + COALESCE(q26::int, 0) + COALESCE(q27::int, 0) + COALESCE(q28::int, 0) + COALESCE(q29::int, 0) + COALESCE(q30::int, 0)) AS score
    FROM
        public.math_day_quiz
)
SELECT
    response_id,
    u.user_id,
    first_name,
    last_name,
    username,
    class_name,
    test_name,
    round(score::numeric / testmaxscore::numeric, 2) AS score_pct,
    test_date
FROM
    quiz_scores_raw m
    LEFT JOIN users u ON m.user_id = u.user_id
    LEFT JOIN quiz_marks q ON m.test = q.test_id
        AND m.course = q.course
        AND m.module = q.module;

