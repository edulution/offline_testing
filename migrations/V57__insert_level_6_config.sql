-- Insert Level 6 course
INSERT INTO public.course (
    module,
    course,
    course_family,
    sort_order,
    channel_id)
VALUES (
    'numeracy',
    'level_6',
    'Level 6',
    60,
    NULL);

-- Insert Level 6 pre and post tests
INSERT INTO public.test_marks (
    test_id,
    test_name,
    course,
    module,
    testmaxscore,
    test_pass_score,
    channel_id,
    test_type,
    test_seq)
VALUES (
    'level_6_pre',
    'Level 6 Pre-Test',
    'level_6',
    'numeracy',
    50,
    0.75,
    NULL,
    'TST',
    1);

INSERT INTO public.test_marks (
    test_id,
    test_name,
    course,
    module,
    testmaxscore,
    test_pass_score,
    channel_id,
    test_type,
    test_seq)
VALUES (
    'level_6_post',
    'Level 6 Post-Test',
    'level_6',
    'numeracy',
    50,
    0.75,
    NULL,
    'TST',
    5);

-- Insert Level 6 testlets
INSERT INTO public.test_marks (
    test_id,
    test_name,
    course,
    module,
    testmaxscore,
    test_pass_score,
    channel_id,
    test_type,
    test_seq)
VALUES (
    'level_6_sec_1',
    'Level 6 Section 1 Testlet',
    'level_6',
    'numeracy',
    15,
    0.75,
    'cf1b82ba14524cf78a08ce8c01626b28',
    'TLT',
    1);

INSERT INTO public.test_marks (
    test_id,
    test_name,
    course,
    module,
    testmaxscore,
    test_pass_score,
    channel_id,
    test_type,
    test_seq)
VALUES (
    'level_6_sec_2',
    'Level 6 Section 2 Testlet',
    'level_6',
    'numeracy',
    15,
    0.75,
    'b21103bd85f64e18b6a6e4cb50665386',
    'TLT',
    2);

INSERT INTO public.test_marks (
    test_id,
    test_name,
    course,
    module,
    testmaxscore,
    test_pass_score,
    channel_id,
    test_type,
    test_seq)
VALUES (
    'level_6_sec_3',
    'Level 6 Section 3 Testlet',
    'level_6',
    'numeracy',
    15,
    0.75,
    '20e95963caea4ab5ac505c60f3c5a5bb',
    'TLT',
    3);

INSERT INTO public.test_marks (
    test_id,
    test_name,
    course,
    module,
    testmaxscore,
    test_pass_score,
    channel_id,
    test_type,
    test_seq)
VALUES (
    'level_6_sec_4',
    'Level 6 Section 4 Testlet',
    'level_6',
    'numeracy',
    15,
    0.75,
    '1ab4e3287ce745ee9166bb13021a3b55',
    'TLT',
    4);

-- Insert level 6 topics
INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    '77e5b96b-3ca5-441b-bfb1-14685e137873',
    'Whole Numbers',
    'L6S1_WHLN',
    'cf1b82ba-1452-4cf7-8a08-ce8c01626b28',
    'Level 6 - Section 1',
    1);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'Negative Numbers',
    'L6S1_NGTN',
    'cf1b82ba-1452-4cf7-8a08-ce8c01626b28',
    'Level 6 - Section 1',
    2);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    '43b8d516-7938-4107-b9c1-2e40ee42234f',
    'Exponents',
    'L6S1_EXPN',
    'cf1b82ba-1452-4cf7-8a08-ce8c01626b28',
    'Level 6 - Section 1',
    3);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'Algebraic Expressions',
    'L6S1_ALGBRCEX',
    'cf1b82ba-1452-4cf7-8a08-ce8c01626b28',
    'Level 6 - Section 1',
    4);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'Common Fractions',
    'L6S2_CMMF',
    'b21103bd-85f6-4e18-b6a6-e4cb50665386',
    'Level 6 - Section 2',
    3);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    'b3d2bc9e-3480-4da8-9c5b-b48753b3c1e0',
    'Exponents',
    'L6S2_EXPN',
    'b21103bd-85f6-4e18-b6a6-e4cb50665386',
    'Level 6 - Section 2',
    1);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'Algebraic Equations',
    'L6S2_ALGBRCEQ',
    'b21103bd-85f6-4e18-b6a6-e4cb50665386',
    'Level 6 - Section 2',
    2);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    'e5961084-97a1-4ba8-8c82-1406fc0bb657',
    'Equations And Inequations',
    'L6S2_EQAI',
    'b21103bd-85f6-4e18-b6a6-e4cb50665386',
    'Level 6 - Section 2',
    4);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    'e7a3ee8a-c3fd-438c-a7f0-440ce708c894',
    'Theorem Of Pythagoras',
    'L6S3_THOP',
    '20e95963-caea-4ab5-ac50-5c60f3c5a5bb',
    'Level 6 - Section 3',
    1);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'Geometry Of Straight Lines',
    'L6S3_GOSL',
    '20e95963-caea-4ab5-ac50-5c60f3c5a5bb',
    'Level 6 - Section 3',
    2);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    '147028c1-3531-4f99-81db-3a163591be2c',
    'Equations & Inequations',
    'L6S3_EEAI',
    '20e95963-caea-4ab5-ac50-5c60f3c5a5bb',
    'Level 6 - Section 3',
    3);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    '1f504dce-bda7-440f-9dcd-ad8be9eab8da',
    'Geometry Of 2D Shapes',
    'L6S4_GO2S',
    '1ab4e328-7ce7-45ee-9166-bb13021a3b55',
    'Level 6 - Section 4',
    1);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    '64223029-1d8c-4127-b624-27922289ef9f',
    'Perimeter & Area Of 2D Shapes',
    'L6S4_PAAO2S',
    '1ab4e328-7ce7-45ee-9166-bb13021a3b55',
    'Level 6 - Section 4',
    2);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'Algebraic Graphs',
    'L6S4_ALGG',
    '1ab4e328-7ce7-45ee-9166-bb13021a3b55',
    'Level 6 - Section 4',
    3);

INSERT INTO test_topics (
    topic_id,
    topic_name,
    topic_abbr,
    channel_id,
    channel_name,
    sort_order)
VALUES (
    '6feaece8-c8b8-4744-b8fb-1ae7832e9360',
    'Transformation Geometry',
    'L6S4_TRNG',
    '1ab4e328-7ce7-45ee-9166-bb13021a3b55',
    'Level 6 - Section 4',
    4);


-- Insert test questions for all Level 6 Tests and Testlets
INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5247,
    1,
    'A',
    'Undefined',
    '77e5b96b-3ca5-441b-bfb1-14685e137873',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5248,
    2,
    'D',
    '64',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5249,
    3,
    'A',
    '-2',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5250,
    4,
    'C',
    '7',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5251,
    5,
    'D',
    '6',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5252,
    6,
    'B',
    '54',
    '43b8d516-7938-4107-b9c1-2e40ee42234f',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5253,
    7,
    'C',
    '1250',
    '43b8d516-7938-4107-b9c1-2e40ee42234f',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5254,
    8,
    'A',
    '515',
    'b3d2bc9e-3480-4da8-9c5b-b48753b3c1e0',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5255,
    9,
    'B',
    '310',
    'b3d2bc9e-3480-4da8-9c5b-b48753b3c1e0',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5256,
    10,
    'C',
    '5',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5257,
    11,
    'C',
    '2<U+0001D465> - 10',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5258,
    12,
    'B',
    '5a',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5259,
    13,
    'C',
    '2a - <U+0001D44F>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5260,
    14,
    'B',
    '- 3a - 3<U+0001D44F>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5261,
    15,
    'A',
    'a2 - a<U+0001D44F>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5262,
    16,
    'C',
    '2ac',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5263,
    17,
    'A',
    '-4',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5264,
    18,
    'A',
    '-0.9a &plus; 1.45<U+0001D44F>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5265,
    19,
    'B',
    'a = 4',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5266,
    20,
    'D',
    '<U+0001D465> = -43',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5267,
    21,
    'B',
    '<U+0001D44F> = -3',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5268,
    22,
    'D',
    '<U+0001D465> = 13',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5269,
    23,
    'B',
    '<U+0001D466> = 85',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5270,
    24,
    'B',
    '<U+0001D465> = 2',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5271,
    25,
    'C',
    '-58',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5272,
    26,
    'D',
    '4915',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5273,
    27,
    'B',
    '12',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5274,
    28,
    'A',
    '-1516',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5275,
    29,
    'B',
    '-18920',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5276,
    30,
    'C',
    '154',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5277,
    31,
    'B',
    '13 cm',
    'e7a3ee8a-c3fd-438c-a7f0-440ce708c894',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5278,
    32,
    'C',
    '7 cm',
    'e7a3ee8a-c3fd-438c-a7f0-440ce708c894',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5279,
    33,
    'A',
    'A and D',
    'e7a3ee8a-c3fd-438c-a7f0-440ce708c894',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5280,
    34,
    'B',
    'AB^D = 42°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5281,
    35,
    'C',
    'EF^H = 147°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5282,
    36,
    'B',
    'MK^J = 120°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5283,
    37,
    'B',
    'ED^A = 90°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5284,
    38,
    'B',
    'IK^J = 78°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5285,
    39,
    'C',
    'XQ^R = 32°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5286,
    40,
    'A',
    'YQ^P = 43°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5287,
    41,
    'B',
    'XQ^P = 148°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5288,
    42,
    'A',
    'BA^C = 80°',
    '1f504dce-bda7-440f-9dcd-ad8be9eab8da',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5289,
    43,
    'B',
    'F&Gcirc;E = 30°',
    '1f504dce-bda7-440f-9dcd-ad8be9eab8da',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5290,
    44,
    'B',
    'p × 10',
    '64223029-1d8c-4127-b624-27922289ef9f',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5291,
    45,
    'C',
    'p × 25',
    '64223029-1d8c-4127-b624-27922289ef9f',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5292,
    46,
    'B',
    'v÷ p',
    '64223029-1d8c-4127-b624-27922289ef9f',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5293,
    47,
    'A',
    'A',
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5294,
    48,
    'D',
    'D',
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5295,
    49,
    'B',
    '<U+0001D466> = -<U+0001D465> &plus; 3',
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5296,
    50,
    'C',
    'rotation',
    '6feaece8-c8b8-4744-b8fb-1ae7832e9360',
    'level_6_post',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5297,
    1,
    'A',
    'Undefined',
    '77e5b96b-3ca5-441b-bfb1-14685e137873',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5298,
    2,
    'D',
    '64',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5299,
    3,
    'A',
    '-2',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5300,
    4,
    'C',
    '7',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5301,
    5,
    'D',
    '6',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5302,
    6,
    'B',
    '54',
    '43b8d516-7938-4107-b9c1-2e40ee42234f',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5303,
    7,
    'C',
    '1250',
    '43b8d516-7938-4107-b9c1-2e40ee42234f',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5304,
    8,
    'A',
    '515',
    'b3d2bc9e-3480-4da8-9c5b-b48753b3c1e0',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5305,
    9,
    'B',
    '310',
    'b3d2bc9e-3480-4da8-9c5b-b48753b3c1e0',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5306,
    10,
    'C',
    '5',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5307,
    11,
    'C',
    '2<U+0001D465> - 10',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5308,
    12,
    'B',
    '5a',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5309,
    13,
    'C',
    '2a - <U+0001D44F>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5310,
    14,
    'B',
    '- 3a - 3<U+0001D44F>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5311,
    15,
    'A',
    'a2 - a<U+0001D44F>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5312,
    16,
    'C',
    '2ac',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5313,
    17,
    'A',
    '-4',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5314,
    18,
    'A',
    '-0.9a &plus; 1.45<U+0001D44F>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5315,
    19,
    'B',
    'a = 4',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5316,
    20,
    'D',
    '<U+0001D465> = -43',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5317,
    21,
    'B',
    '<U+0001D44F> = -3',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5318,
    22,
    'D',
    '<U+0001D465> = 13',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5319,
    23,
    'B',
    '<U+0001D466> = 85',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5320,
    24,
    'B',
    '<U+0001D465> = 2',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5321,
    25,
    'C',
    '-58',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5322,
    26,
    'D',
    '4915',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5323,
    27,
    'B',
    '12',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5324,
    28,
    'A',
    '-1516',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5325,
    29,
    'B',
    '-18920',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5326,
    30,
    'C',
    '154',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5327,
    31,
    'B',
    '13 cm',
    'e7a3ee8a-c3fd-438c-a7f0-440ce708c894',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5328,
    32,
    'C',
    '7 cm',
    'e7a3ee8a-c3fd-438c-a7f0-440ce708c894',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5329,
    33,
    'A',
    'A and D',
    'e7a3ee8a-c3fd-438c-a7f0-440ce708c894',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5330,
    34,
    'B',
    'AB^D = 42°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5331,
    35,
    'C',
    'EF^H = 147°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5332,
    36,
    'B',
    'MK^J = 120°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5333,
    37,
    'B',
    'ED^A = 90°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5334,
    38,
    'B',
    'IK^J = 78°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5335,
    39,
    'C',
    'XQ^R = 32°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5336,
    40,
    'A',
    'YQ^P = 43°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5337,
    41,
    'B',
    'XQ^P = 148°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5338,
    42,
    'A',
    'BA^C = 80°',
    '1f504dce-bda7-440f-9dcd-ad8be9eab8da',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5339,
    43,
    'B',
    'F&Gcirc;E = 30°',
    '1f504dce-bda7-440f-9dcd-ad8be9eab8da',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5340,
    44,
    'B',
    'p × 10',
    '64223029-1d8c-4127-b624-27922289ef9f',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5341,
    45,
    'C',
    'p × 25',
    '64223029-1d8c-4127-b624-27922289ef9f',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5342,
    46,
    'B',
    'v48÷ p',
    '64223029-1d8c-4127-b624-27922289ef9f',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5343,
    47,
    'A',
    'A',
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5344,
    48,
    'D',
    'D',
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5345,
    49,
    'B',
    '<U+0001D466> = -<U+0001D465> &plus; 3',
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5346,
    50,
    'C',
    'rotation',
    '6feaece8-c8b8-4744-b8fb-1ae7832e9360',
    'level_6_pre',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5347,
    1,
    'A',
    'Undefined',
    '77e5b96b-3ca5-441b-bfb1-14685e137873',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5348,
    2,
    'A',
    '-25',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5349,
    3,
    'A',
    '-2',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5350,
    4,
    'C',
    '15',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5351,
    5,
    'D',
    '2',
    '1c6c358f-7eb7-4e0b-8524-174a1721f852',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5352,
    6,
    'B',
    '35',
    '43b8d516-7938-4107-b9c1-2e40ee42234f',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5353,
    7,
    'A',
    '1',
    '43b8d516-7938-4107-b9c1-2e40ee42234f',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5354,
    8,
    'B',
    '1',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5355,
    9,
    'C',
    '5<U+0001D465> &plus; 15',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5356,
    10,
    'B',
    '6<U+0001D44F>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5357,
    11,
    'C',
    '4<U+0001D465> - <U+0001D466>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5358,
    12,
    'B',
    '5<U+0001D465> &plus; 5<U+0001D466>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5359,
    13,
    'A',
    '2<U+0001D465>2 - 2<U+0001D465><U+0001D466>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5360,
    14,
    'C',
    '3<U+0001D465><U+0001D467>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5361,
    15,
    'C',
    '-5<U+0001D465>',
    '488259c1-2134-483c-9fc8-da9ee408622d',
    'level_6_sec_1',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5362,
    1,
    'A',
    '420',
    'b3d2bc9e-3480-4da8-9c5b-b48753b3c1e0',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5363,
    2,
    'B',
    '218',
    'b3d2bc9e-3480-4da8-9c5b-b48753b3c1e0',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5364,
    3,
    'A',
    '<U+0001D466> = 4',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5365,
    4,
    'B',
    'a = -114',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5366,
    5,
    'B',
    'a = 18',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5367,
    6,
    'B',
    'p = 7',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5368,
    7,
    'B',
    'q = 1',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5369,
    8,
    'A',
    '<U+0001D465> = 2',
    '32c570ee-3a93-4f58-ad5b-1009efe1299b',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5370,
    9,
    'C',
    '-25',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5371,
    10,
    'D',
    '1234',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5372,
    11,
    'B',
    '10',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5373,
    12,
    'A',
    '-1',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5374,
    13,
    'A',
    '-357',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5375,
    14,
    'D',
    '312',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5376,
    15,
    'D',
    '613',
    '0a0ce9f4-41fb-4bc6-8823-6affd1bf189d',
    'level_6_sec_2',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5377,
    1,
    'A',
    'DF = 17 cm',
    'e7a3ee8a-c3fd-438c-a7f0-440ce708c894',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5378,
    2,
    'B',
    'TU = 12 cm',
    'e7a3ee8a-c3fd-438c-a7f0-440ce708c894',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5379,
    3,
    'A',
    'A and D',
    'e7a3ee8a-c3fd-438c-a7f0-440ce708c894',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5380,
    4,
    'A',
    'DB^C = 48°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5381,
    5,
    'B',
    'DB^A = 143°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5382,
    6,
    'A',
    'AB^E = 60°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5383,
    7,
    'B',
    'UR^S = 30°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5384,
    8,
    'B',
    'PR^Q = 78°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5385,
    9,
    'D',
    'HB^C = 153°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5386,
    10,
    'A',
    'DF^H = 27°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5387,
    11,
    'C',
    'IB^J = 114°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5388,
    12,
    'D',
    'Acute',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5389,
    13,
    'A',
    '<U+0001D465> = 34°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5390,
    14,
    'B',
    'MP^N = 120°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5391,
    15,
    'D',
    '116°',
    '47a622e6-fa06-484b-b34b-fa9519194441',
    'level_6_sec_3',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5392,
    1,
    'D',
    'BA^C = 108°',
    '1f504dce-bda7-440f-9dcd-ad8be9eab8da',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5393,
    2,
    'A',
    'DF^E = 15°',
    '1f504dce-bda7-440f-9dcd-ad8be9eab8da',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5394,
    3,
    'D',
    'GZ^J = 105°',
    '1f504dce-bda7-440f-9dcd-ad8be9eab8da',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5395,
    4,
    'B',
    'p × 24',
    '64223029-1d8c-4127-b624-27922289ef9f',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5396,
    5,
    'C',
    'p × 144',
    '64223029-1d8c-4127-b624-27922289ef9f',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5397,
    6,
    'C',
    '25p',
    '64223029-1d8c-4127-b624-27922289ef9f',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5398,
    7,
    'B',
    'v p',
    '64223029-1d8c-4127-b624-27922289ef9f',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5399,
    8,
    'C',
    'C',
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5400,
    9,
    'D',
    'D',
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5401,
    10,
    'C',
    'C',
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5402,
    11,
    'C',
    '<U+0001D466> = <U+0001D465> - 3',
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5403,
    12,
    'C',
    '<U+0001D466> = 4',
    'c4b373ec-af2c-4d15-b950-7eaca86d3da1',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5404,
    13,
    'C',
    'C',
    '6feaece8-c8b8-4744-b8fb-1ae7832e9360',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5405,
    14,
    'B',
    'reflection',
    '6feaece8-c8b8-4744-b8fb-1ae7832e9360',
    'level_6_sec_4',
    'level_6',
    'numeracy');

INSERT INTO test_questions (
    source_blquestion_id,
    question_index,
    correct_answer_value,
    correct_answer_text,
    topic_id,
    test,
    course,
    module)
VALUES (
    5406,
    15,
    'C',
    '<U+0001D465> = 0 (The <U+0001D466> - axis)',
    '6feaece8-c8b8-4744-b8fb-1ae7832e9360',
    'level_6_sec_4',
    'level_6',
    'numeracy');

