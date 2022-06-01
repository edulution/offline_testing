-- View that contains data from the responses table pivoted longer
-- questions and answers in single colummns
DROP VIEW IF EXISTS vresponseslong;

CREATE OR REPLACE VIEW vresponseslong AS
SELECT
    response_id,
    user_id,
    sex,
    grade,
    gr7_exam_number,
    test,
    course,
    module,
    test_date,
    unnest(ARRAY['q1', 'q2', 'q3', 'q4', 'q5', 'q6', 'q7', 'q8', 'q9', 'q10', 'q11', 'q12', 'q13', 'q14', 'q15', 'q16', 'q17', 'q18', 'q19', 'q20', 'q21', 'q22', 'q23', 'q24', 'q25', 'q26', 'q27', 'q28', 'q29', 'q30', 'q31', 'q32', 'q33', 'q34', 'q35', 'q36', 'q37', 'q38', 'q39', 'q40', 'q41', 'q42', 'q43', 'q44', 'q45', 'q46', 'q47', 'q48', 'q49', 'q50', 'q51', 'q52', 'q53', 'q54', 'q55', 'q56', 'q57', 'q58', 'q59', 'q60', 'q61', 'q62', 'q63', 'q64', 'q65', 'q66', 'q67', 'q68', 'q69', 'q70']) AS question_number,
    unnest(ARRAY[q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, q32, q33, q34, q35, q36, q37, q38, q39, q40, q41, q42, q43, q44, q45, q46, q47, q48, q49, q50, q51, q52, q53, q54, q55, q56, q57, q58, q59, q60, q61, q62, q63, q64, q65, q66, q67, q68, q69, q70]) AS answer
FROM
    responses;

CREATE OR REPLACE VIEW vresponses AS
-- TODO: Join test marks here. Add wt(weight) column. Weight of each question in test  = 1/testmaxscore
-- TODO: Find better name for this view. vresponses is too amibiguous
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


-- View: public.vtestscorebytopic
-- DROP VIEW public.vtestscorebytopic;
CREATE OR REPLACE VIEW public.vtestscorebytopic AS
-- TODO: remove redundant join to test questions and test marks
-- TODO: Add total weight column for each topic. Test score is weighted average of topic scores
SELECT
    u.username::text AS username,
    tm.test_name::text AS test_name,
    vr.response_id,
    vr.user_id,
    tq.topic_id,
    tt.topic_name::text AS topic_name,
    tt.channel_name::text AS channel_name,
    tt.channel_id::text AS channel_id,
    vr.course::text AS course,
    vr.module::text AS module,
    vr.test_date::text AS test_date,
    avg(vr.answer::numeric) AS answer
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
    u.username,
    tm.test_name,
    vr.response_id,
    vr.user_id,
    tq.topic_id,
    tt.topic_name,
    tt.channel_name,
    tt.channel_id,
    vr.course,
    vr.module,
    vr.test_date;