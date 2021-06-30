-- Remove sort order from the existing numeracy courses (Effectively "disabling" the old courses in other logic)
UPDATE course SET sort_order = NULL WHERE module = 'numeracy';

-- Insert Level 1 to Level 5 into course table
INSERT INTO public.course(
	module, course, sort_order, channel_id)
	VALUES ('numeracy', 'level_1', 10, NULL);
INSERT INTO public.course(
	module, course, sort_order, channel_id)
	VALUES ('numeracy', 'level_2', 20, NULL);
INSERT INTO public.course(
	module, course, sort_order, channel_id)
	VALUES ('numeracy', 'level_3', 30, NULL);
INSERT INTO public.course(
	module, course, sort_order, channel_id)
	VALUES ('numeracy', 'level_4', 40, NULL);
INSERT INTO public.course(
	module, course, sort_order, channel_id)
	VALUES ('numeracy', 'level_5', 50, NULL);
