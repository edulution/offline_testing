/*Insert config for Brombacher assessments*/
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('brom_eval_1', 'Grade 4 Benchmark', 'ext_eval', 'numeracy', 48, 0.75, NULL);

INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('brom_eval_2', 'Grade 5 Benchmark', 'ext_eval', 'numeracy', 48, 0.75, NULL);

INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('brom_eval_3', 'Grade 6 Benchmark', 'ext_eval', 'numeracy', 48, 0.75, NULL);