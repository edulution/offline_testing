/*This view calculates the test scores for all test responses*/
CREATE OR REPLACE VIEW vresponsescore AS
SELECT r.user_id,
       r.module,
       r.course,
       r.test,
       r.test_date,
       r.score,
       r.testmaxscore,
       r.test_pass_score,
       CASE
           WHEN r.score >= (r.testmaxscore::numeric * r.test_pass_score) THEN TRUE
           ELSE FALSE
       END AS passed,
       r.sort_order,
       r.channel_id
FROM
  (SELECT responses.user_id,
          responses.module,
          responses.course,
          responses.test,
          responses.test_date,
          COALESCE(responses.q1::numeric, 0::numeric) +
          COALESCE(responses.q2::numeric, 0::numeric) +
          COALESCE(responses.q3::numeric, 0::numeric) +
          COALESCE(responses.q4::numeric, 0::numeric) +
          COALESCE(responses.q5::numeric, 0::numeric) +
          COALESCE(responses.q6::numeric, 0::numeric) +
          COALESCE(responses.q7::numeric, 0::numeric) +
          COALESCE(responses.q8::numeric, 0::numeric) +
          COALESCE(responses.q9::numeric, 0::numeric) +
          COALESCE(responses.q10::numeric, 0::numeric) +
          COALESCE(responses.q11::numeric, 0::numeric) +
          COALESCE(responses.q12::numeric, 0::numeric) +
          COALESCE(responses.q13::numeric, 0::numeric) +
          COALESCE(responses.q14::numeric, 0::numeric) +
          COALESCE(responses.q15::numeric, 0::numeric) +
          COALESCE(responses.q16::numeric, 0::numeric) +
          COALESCE(responses.q17::numeric, 0::numeric) +
          COALESCE(responses.q18::numeric, 0::numeric) +
          COALESCE(responses.q19::numeric, 0::numeric) +
          COALESCE(responses.q20::numeric, 0::numeric) +
          COALESCE(responses.q21::numeric, 0::numeric) +
          COALESCE(responses.q22::numeric, 0::numeric) +
          COALESCE(responses.q23::numeric, 0::numeric) +
          COALESCE(responses.q24::numeric, 0::numeric) +
          COALESCE(responses.q25::numeric, 0::numeric) +
          COALESCE(responses.q26::numeric, 0::numeric) +
          COALESCE(responses.q27::numeric, 0::numeric) +
          COALESCE(responses.q28::numeric, 0::numeric) +
          COALESCE(responses.q29::numeric, 0::numeric) +
          COALESCE(responses.q30::numeric, 0::numeric) +
          COALESCE(responses.q31::numeric, 0::numeric) +
          COALESCE(responses.q32::numeric, 0::numeric) +
          COALESCE(responses.q33::numeric, 0::numeric) +
          COALESCE(responses.q34::numeric, 0::numeric) +
          COALESCE(responses.q35::numeric, 0::numeric) +
          COALESCE(responses.q36::numeric, 0::numeric) +
          COALESCE(responses.q37::numeric, 0::numeric) +
          COALESCE(responses.q38::numeric, 0::numeric) +
          COALESCE(responses.q39::numeric, 0::numeric) +
          COALESCE(responses.q40::numeric, 0::numeric) +
          COALESCE(responses.q41::numeric, 0::numeric) +
          COALESCE(responses.q42::numeric, 0::numeric) +
          COALESCE(responses.q43::numeric, 0::numeric) +
          COALESCE(responses.q44::numeric, 0::numeric) +
          COALESCE(responses.q45::numeric, 0::numeric) +
          COALESCE(responses.q46::numeric, 0::numeric) +
          COALESCE(responses.q47::numeric, 0::numeric) +
          COALESCE(responses.q48::numeric, 0::numeric) +
          COALESCE(responses.q49::numeric, 0::numeric) +
          COALESCE(responses.q50::numeric, 0::numeric) +
          COALESCE(responses.q51::numeric, 0::numeric) +
          COALESCE(responses.q52::numeric, 0::numeric) +
          COALESCE(responses.q53::numeric, 0::numeric) +
          COALESCE(responses.q54::numeric, 0::numeric) +
          COALESCE(responses.q55::numeric, 0::numeric) +
          COALESCE(responses.q56::numeric, 0::numeric) +
          COALESCE(responses.q57::numeric, 0::numeric) +
          COALESCE(responses.q58::numeric, 0::numeric) +
          COALESCE(responses.q59::numeric, 0::numeric) +
          COALESCE(responses.q60::numeric, 0::numeric) +
          COALESCE(responses.q61::numeric, 0::numeric) +
          COALESCE(responses.q62::numeric, 0::numeric) +
          COALESCE(responses.q63::numeric, 0::numeric) +
          COALESCE(responses.q64::numeric, 0::numeric) +
          COALESCE(responses.q65::numeric, 0::numeric) +
          COALESCE(responses.q66::numeric, 0::numeric) +
          COALESCE(responses.q67::numeric, 0::numeric) +
          COALESCE(responses.q68::numeric, 0::numeric) +
          COALESCE(responses.q69::numeric, 0::numeric) +
          COALESCE(responses.q70::numeric, 0::numeric) AS score,
          t.testmaxscore,
          t.test_pass_score,
          c.sort_order,
          c.channel_id
   FROM responses responses,
        course c,
        test_marks t
   WHERE responses.test::text = t.test_id::text
     AND responses.module::text = t.module::text
     AND responses.module = c.module
     AND responses.course = c.course) r;

