-- Create test questions table
CREATE TABLE public.skillshub_marks (
    test_id varchar NOT NULL,
    test_name varchar NOT NULL,
    course varchar NOT NULL,
    module varchar NOT NULL,
	testmaxscore varchar
);


INSERT INTO public.skillshub_marks(
	test_id, test_name, course, module, testmaxscore)
VALUES 
    ('literacy_assessment','Literacy Assessment','literacy_quiz', 'literacy', 20),
    ('math_assessment','Math Assessment','math_quiz', 'numeracy', 20);