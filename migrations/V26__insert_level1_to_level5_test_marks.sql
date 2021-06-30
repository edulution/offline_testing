-- Insert test marks for level 1 to level 5 pre and post tests
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_1_pre','Level 1 Pre-Test','level_1', 'numeracy', 50, 0.75, NULL);
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_2_pre','Level 2 Pre-Test','level_2', 'numeracy', 50, 0.75, NULL);
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_3_pre','Level 3 Pre-Test','level_3', 'numeracy', 50, 0.75, NULL);
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_4_pre','Level 4 Pre-Test','level_4', 'numeracy', 50, 0.75, NULL);
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_5_pre','Level 5 Pre-Test','level_5', 'numeracy', 50, 0.75, NULL);
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_1_post','Level 1 Post-Test','level_1', 'numeracy', 50, 0.75, NULL);
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_2_post','Level 2 Post-Test','level_2', 'numeracy', 50, 0.75, NULL);
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_3_post','Level 3 Post-Test','level_3', 'numeracy', 50, 0.75, NULL);
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_4_post','Level 4 Post-Test','level_4', 'numeracy', 50, 0.75, NULL);
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_5_post','Level 5 Post-Test','level_5', 'numeracy', 50, 0.75, NULL);


-- Insert test marks for the level 1 to level 5 testlets
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_1_sec_1','Level 1 Section 1 Testlet', 'level_1', 'numeracy', 15, 0.75, 'f3f6bf4b9c424b6fbd90bece1418a415');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_1_sec_2','Level 1 Section 2 Testlet', 'level_1', 'numeracy', 15, 0.75, '3a126f041a9e4127978bb6544a099d0d');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_1_sec_3','Level 1 Section 3 Testlet', 'level_1', 'numeracy', 15, 0.75, '03761fe9a2424e9ebd367fbae14dc134');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_1_sec_4','Level 1 Section 4 Testlet', 'level_1', 'numeracy', 15, 0.75, 'f12e2f67d5894b34bb942484d880c4a6');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_2_sec_1','Level 2 Section 1 Testlet', 'level_2', 'numeracy', 15, 0.75, 'f6e8f1f569c54bc58ecb54d826cd3783');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_2_sec_2','Level 2 Section 2 Testlet', 'level_2', 'numeracy', 15, 0.75, '5126a907e5284345847c8ca749c8cd9b');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_2_sec_3','Level 2 Section 3 Testlet', 'level_2', 'numeracy', 15, 0.75, 'c32737bf26474dc8a81de3d093075830');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_2_sec_4','Level 2 Section 4 Testlet', 'level_2', 'numeracy', 15, 0.75, '0985900c047a41738e796f19d9b57ed5');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_3_sec_1','Level 3 Section 1 Testlet', 'level_3', 'numeracy', 15, 0.75, 'c0302f6cd0624778bc8dd7a2b91d09b4');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_3_sec_2','Level 3 Section 2 Testlet', 'level_3', 'numeracy', 15, 0.75, 'ddf25e8fcde84e8998118daffb2d8655');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_3_sec_3','Level 3 Section 3 Testlet', 'level_3', 'numeracy', 15, 0.75, 'e2217b872f784190a0a55c46e9ee8bc1');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_3_sec_4','Level 3 Section 4 Testlet', 'level_3', 'numeracy', 15, 0.75, 'f908fac9fe5644b996abe25dfbd530bc');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_4_sec_1','Level 4 Section 1 Testlet', 'level_4', 'numeracy', 15, 0.75, 'd4b44e6dd4de450ebbc799085ba656e5');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_4_sec_2','Level 4 Section 2 Testlet', 'level_4', 'numeracy', 15, 0.75, '763eafc24e684dbe8f54c9a22dd63599');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_4_sec_3','Level 4 Section 3 Testlet', 'level_4', 'numeracy', 15, 0.75, '7de1d8eca4874856b508c1a4f51a839e');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_4_sec_4','Level 4 Section 4 Testlet', 'level_4', 'numeracy', 15, 0.75, '904d419f53e24b6fb60d2aca7e729683');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_5_sec_1','Level 5 Section 1 Testlet', 'level_5', 'numeracy', 15, 0.75, '5b679315a02c40359505fc84701c482d');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_5_sec_2','Level 5 Section 2 Testlet', 'level_5', 'numeracy', 15, 0.75, 'a5cd9f9f000e41459a95875d7dfd3e68');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_5_sec_3','Level 5 Section 3 Testlet', 'level_5', 'numeracy', 15, 0.75, '6c4089232a72447eabbdf83b7c5612a4');
INSERT INTO public.test_marks(
	test_id, test_name, course, module, testmaxscore, test_pass_score, channel_id)
	VALUES ('level_5_sec_4','Level 5 Section 4 Testlet', 'level_5', 'numeracy', 15, 0.75, '28f4920a7b444e29af4f1e8d00ca332b');