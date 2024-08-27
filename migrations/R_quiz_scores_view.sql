CREATE VIEW public.quiz_scores_view AS
SELECT 
    response_id,
    user_id,
    course,
    module,
    test,
    test_date,
    (COALESCE(q1::int, 0) + COALESCE(q2::int, 0) + COALESCE(q3::int, 0) + 
    COALESCE(q4::int, 0) + COALESCE(q5::int, 0) + COALESCE(q6::int, 0) + 
    COALESCE(q7::int, 0) + COALESCE(q8::int, 0) + COALESCE(q9::int, 0) + 
    COALESCE(q10::int, 0) + COALESCE(q11::int, 0) + COALESCE(q12::int, 0) + 
    COALESCE(q13::int, 0) + COALESCE(q14::int, 0) + COALESCE(q15::int, 0) +
    COALESCE(q16::int, 0) + COALESCE(q17::int, 0) + COALESCE(q18::int, 0) +
    COALESCE(q19::int, 0) + COALESCE(q20::int, 0) + COALESCE(q21::int, 0) +
    COALESCE(q22::int, 0) + COALESCE(q23::int, 0) + COALESCE(q24::int, 0) +
    COALESCE(q25::int, 0) + COALESCE(q26::int, 0) + COALESCE(q27::int, 0) +
    COALESCE(q28::int, 0) + COALESCE(q29::int, 0) + COALESCE(q30::int, 0)) AS total_quiz_score
FROM 
    public.math_day_quiz
ORDER BY 
    total_score DESC;
