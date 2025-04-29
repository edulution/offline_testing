-- Create test questions table
CREATE TABLE public.skillshub_marks (
    test_id varchar NOT NULL,
    test_name varchar NOT NULL,
    course varchar NOT NULL,
    module varchar NOT NULL,
	testmaxscore varchar
);


-- Insert test marks for skillshub_assessments  
INSERT INTO public.skillshub_marks(
	test_id, test_name, course, module, testmaxscore)
	VALUES ('literacy_assessment','Literacy Assessment','literacy_quiz', 'literacy', 20);
INSERT INTO public.skillshub_marks(
	test_id, test_name, course, module, testmaxscore)
	VALUES ('math_assessment','Math Assessment','math_quiz', 'numeracy', 20);
