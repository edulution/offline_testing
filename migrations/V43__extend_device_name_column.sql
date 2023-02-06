-- Extend the name column of the device table to 5 characters
ALTER TABLE device
    ALTER COLUMN "name" TYPE varchar(5);

-- brom_eval_4_config
-- Insert config for Grade 7 external evaluation test
INSERT INTO public.test_marks(
    test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
    VALUES ('brom_eval_4', 'Grade 7 Evaluation', 'ext_eval', 'numeracy', 48, 0.75, NULL);