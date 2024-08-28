-- Create test questions table
CREATE TABLE public.quiz_marks (
    test_id varchar NOT NULL,
    test_name varchar NOT NULL,
    course varchar NOT NULL,
    module varchar NOT NULL,
	testmaxscore varchar
);


-- Insert test marks for math_quizzes
INSERT INTO public.quiz_marks(
	test_id, test_name, course, module, testmaxscore)
	VALUES ('grade_4_quiz','Grade 4 Math Quiz','math_quiz', 'numeracy', 19);
INSERT INTO public.quiz_marks(
	test_id, test_name, course, module, testmaxscore)
	VALUES ('grade_5_quiz','Grade 5 Math Quiz','math_quiz', 'numeracy', 15);
INSERT INTO public.quiz_marks(
	test_id, test_name, course, module, testmaxscore)
	VALUES ('grade_6_quiz','Grade 6 Math Quiz','math_quiz', 'numeracy', 30);