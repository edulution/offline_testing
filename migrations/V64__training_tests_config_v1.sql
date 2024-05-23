INSERT INTO public.course(
	module, course, sort_order, channel_id, course_family)
	VALUES ('coach_training', 'tech_training', NULL, NULL, 'Coach Training');

INSERT INTO public.course(
	module, course, sort_order, channel_id, course_family)
	VALUES ('coach_training', 'coach_professional_development', NULL, NULL, 'Coach Training');

INSERT INTO public.test_type(
	test_type, description)
	VALUES ('COA', 'Coach Training');


INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id, test_type, test_seq)
	VALUES ('tech_1', 'Tech Assessment 1', 'tech_training', 'coach_training', 19, 0.75, NULL, 'COA', NULL);

INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id, test_type, test_seq)
	VALUES ('tech_2', 'Tech Assessment 2', 'tech_training', 'coach_training', 10, 0.75, NULL, 'COA', NULL);

INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id, test_type, test_seq)
	VALUES ('tech_3', 'Tech Assessment 3', 'tech_training', 'coach_training', 16, 0.75, NULL, 'COA', NULL);

INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id, test_type, test_seq)
	VALUES ('tech_4', 'Tech Assessment 4', 'tech_training', 'coach_training', 7, 0.75, NULL, 'COA', NULL);

	INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id, test_type, test_seq)
	VALUES ('affirmations', 'Affirmations', 'coach_professional_development', 'coach_training', 5, 0.75, NULL, 'COA', NULL);

	INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id, test_type, test_seq)
	VALUES ('container_building', 'Container Building', 'coach_professional_development', 'coach_training', 5, 0.75, NULL, 'COA', NULL);

	INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id, test_type, test_seq)
	VALUES ('ethos_and_values', 'Ethos and Values', 'coach_professional_development', 'coach_training', 10, 0.75, NULL, 'COA', NULL);

	INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id, test_type, test_seq)
	VALUES ('games_energizers', 'Games and Energizers', 'coach_professional_development', 'coach_training', 5, 0.75, NULL, 'COA', NULL);

	INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id, test_type, test_seq)
	VALUES ('goal_setting', 'Goal Setting', 'coach_professional_development', 'coach_training', 10, 0.75, NULL, 'COA', NULL);

	INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id, test_type, test_seq)
	VALUES ('iceberg', 'Iceberg', 'coach_professional_development', 'coach_training', 5, 0.75, NULL, 'COA', NULL);

	INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id, test_type, test_seq)
	VALUES ('learner_journey', 'Learner Journey', 'coach_professional_development', 'coach_training', 5, 0.75, NULL, 'COA', NULL);