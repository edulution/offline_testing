-- Insert Level 6 course
INSERT INTO public.course(
	module, course, course_family, sort_order, channel_id)
	VALUES ('numeracy', 'level_6', 'Level 6', 60, NULL);

-- Insert Level 6 pre and post tests
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_6_pre','Level 6 Pre-Test','level_6', 'numeracy', 50, 0.75, NULL);
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_6_post','Level 6 Post-Test','level_6', 'numeracy', 50, 0.75, NULL);

-- Insert Level 6 testlets
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_6_sec_1','Level 6 Section 1 Testlet', 'level_6', 'numeracy', 15, 0.75, 'cf1b82ba14524cf78a08ce8c01626b28');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_6_sec_2','Level 6 Section 2 Testlet', 'level_6', 'numeracy', 15, 0.75, 'b21103bd85f64e18b6a6e4cb50665386');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_6_sec_3','Level 6 Section 3 Testlet', 'level_6', 'numeracy', 15, 0.75, '20e95963caea4ab5ac505c60f3c5a5bb');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_6_sec_4','Level 6 Section 4 Testlet', 'level_6', 'numeracy', 15, 0.75, '1ab4e3287ce745ee9166bb13021a3b55');


