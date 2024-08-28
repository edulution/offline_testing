-- Update quiz names
update quiz_marks set test_name = 'Grade 4 Quiz' where test_id = 'grade_4_quiz';
update quiz_marks set test_name = 'Grade 5 Quiz' where test_id = 'grade_5_quiz';
update quiz_marks set test_name = 'Grade 6 Quiz' where test_id = 'grade_6_quiz';

-- update max score for grade 5 quiz
update quiz_marks set testmaxscore = 18 where test_id = 'grade_5_quiz';