-- Insert initial test configurations
INSERT INTO public.skillshub_marks(
    test_id, test_name, course, module, testmaxscore)
VALUES 
    ('skills_hub_literacy_assessment','Literacy Assessment','literacy_quiz', 'literacy', 20),
    ('skills_hub_math_assessment','Math Assessment','math_quiz', 'numeracy', 20);