-- View that contains data from the responses table pivoted longer
-- questions and answers in single colummns

DROP VIEW IF EXISTS vresponseslong;


CREATE OR REPLACE VIEW vresponseslong AS
SELECT response_id,
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
FROM responses;

 -- View: public.vresponsesfull
 -- DROP VIEW public.vresponsesfull;

CREATE OR REPLACE VIEW public.vresponsesfull AS
SELECT responses_joined.username,
       responses_joined.first_name,
       responses_joined.last_name,
       responses_joined.class_name,
       responses_joined.group_name,
       responses_joined.response_id,
       responses_joined.user_id,
       responses_joined.sex,
       responses_joined.grade,
       responses_joined.gr7_exam_number,
       responses_joined.test,
       responses_joined.course,
       responses_joined.module,
       responses_joined.test_date,
       responses_joined.question_number,
       responses_joined.answer,
       responses_joined.topic_id,
       responses_joined.topic_name,
       responses_joined.channel_name,
       responses_joined.channel_id,
       responses_joined.test_name,
       responses_joined.testmaxscore,
       responses_joined.wt
FROM
  (SELECT u.username,
          u.first_name,
          u.last_name,
          u.class_name,
          u.group_name,
          vr.response_id,
          vr.user_id,
          vr.sex,
          vr.grade,
          vr.gr7_exam_number,
          vr.test,
          vr.course,
          vr.module,
          vr.test_date,
          vr.question_number,
          vr.answer,
          tq.topic_id,
          tt.topic_name::text AS topic_name,
          tt.channel_name::text AS channel_name,
          tt.channel_id::text AS channel_id,
          tm.test_name,
          tm.testmaxscore,
          1::numeric / tm.testmaxscore::numeric AS wt
   FROM vresponseslong vr
   LEFT JOIN test_questions tq ON vr.test::text = tq.test::text
   AND split_part(vr.question_number, 'q'::text, 2) = tq.question_index::text
   AND vr.module::text = tq.module::text
   AND vr.course::text = tq.course::text
   LEFT JOIN test_topics tt ON tq.topic_id = tt.topic_id
   LEFT JOIN users u ON vr.user_id = u.user_id
   LEFT JOIN test_marks tm ON vr.test::text = tm.test_id::text
   AND vr.course::text = tm.course::text
   AND vr.module::text = tm.module::text) responses_joined
WHERE responses_joined.topic_id IS NOT NULL;

 -- View: public.vtestscorebytopic
 -- DROP VIEW public.vtestscorebytopic;

CREATE OR REPLACE VIEW public.vtestscorebytopic AS
SELECT vresponsesfull.username,
       vresponsesfull.first_name,
       vresponsesfull.last_name,
       vresponsesfull.test_name,
       vresponsesfull.response_id,
       vresponsesfull.user_id,
       vresponsesfull.topic_id,
       vresponsesfull.topic_name,
       vresponsesfull.channel_name,
       vresponsesfull.channel_id,
       vresponsesfull.course,
       vresponsesfull.module,
       vresponsesfull.test_date,
       COALESCE(avg(vresponsesfull.answer::numeric), 0::numeric) AS topic_score,
       COALESCE(sum(vresponsesfull.wt), 0::numeric) AS total_wt
FROM vresponsesfull
GROUP BY vresponsesfull.username,
         vresponsesfull.first_name,
         vresponsesfull.last_name,
         vresponsesfull.test_name,
         vresponsesfull.response_id,
         vresponsesfull.user_id,
         vresponsesfull.topic_id,
         vresponsesfull.topic_name,
         vresponsesfull.channel_name,
         vresponsesfull.channel_id,
         vresponsesfull.course,
         vresponsesfull.module,
         vresponsesfull.test_date
ORDER BY vresponsesfull.test_date DESC, vresponsesfull.channel_name, vresponsesfull.topic_name, (COALESCE(avg(vresponsesfull.answer::numeric), 0::numeric));