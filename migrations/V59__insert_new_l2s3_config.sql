-- change channel_id for L2S3 from 521f889d-c863-4998-b554-2a526d428b85 to c32737bf-2647-4dc8-a81d-e3d093075830
update test_marks
	set channel_id = '521f889d-c863-4998-b554-2a526d428b85'
	where test_id = 'level_2_sec_3'
	and course = 'level_2'
	and module = 'numeracy';

-- Insert single topic for new level 2 section 3
INSERT INTO public.test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    'a25a6e29-bd4c-49a2-bf41-6385c00c40a9',
    'Numeric patterns',
    'L2S3_NMRP',
    '521f889d-c863-4998-b554-2a526d428b85',
    'Level 2 - Section 3',
    1);

-- Set the topic_id to numeric patterns for all L2S3 questions
update test_questions
	set topic_id = 'a25a6e29-bd4c-49a2-bf41-6385c00c40a9'
	where test = 'level_2_sec_3'
	and course = 'level_2'
	and module = 'numeracy';

-- Update the old L2S3 numeric patterns ID to the new one. Includes free and post tests
update test_questions
	set topic_id = 'a25a6e29-bd4c-49a2-bf41-6385c00c40a9'
	where topic_id = '461b7890-af68-4285-b97f-a10ffc13ac81';

-- Update the old L2S3 common fractions ID to L2S2 common fractions. Includes free and post tests
update test_questions
	set topic_id = 'cf624b4e-bf21-4d65-bea5-b8b3ed34a81e'
	where topic_id = '5a8898ed-e35c-447e-91ac-da16502051fd';
	
-- Delete test topics for old level 2 section 3
delete from test_topics
	where channel_id = 'c32737bf-2647-4dc8-a81d-e3d093075830';

