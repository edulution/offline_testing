-- Alter grade column in skillshub_quiz table to allow for two-digit grades
ALTER TABLE public.skillshub_quiz ALTER COLUMN grade TYPE varchar(2);
