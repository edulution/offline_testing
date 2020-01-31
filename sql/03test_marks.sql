/*create test marks table*/
/*primary key on (test_id,course,module)*/
/*Add composite key to test marks table*/
CREATE TABLE test_marks (
    test_id varchar,
    test_name varchar,
    course varchar,
    module varchar,
    testmaxscore integer,
    test_pass_score numeric(3, 2),
    channel_id uuid,
    PRIMARY KEY(test_id, course, module)
);

/*populate test marks with config for existing numeracy and literacy tests*/
INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('literacy',
        'alpha_a',
        'Alpha A1',
        'alpha_a1',
        50);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('literacy',
        'alpha_a',
        'Alpha A2',
        'alpha_a2',
        50);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('literacy',
        'alpha_b',
        'Alpha B1',
        'alpha_b1',
        50);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('literacy',
        'alpha_b',
        'Alpha B2',
        'alpha_b2',
        50);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('literacy',
        'alpha_c',
        'Alpha C1',
        'alpha_c1',
        50);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('literacy',
        'alpha_c',
        'Alpha C2',
        'alpha_c2',
        50);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('literacy',
        'alpha_d',
        'Alpha D1',
        'alpha_d1',
        60);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('literacy',
        'alpha_d',
        'Alpha D2',
        'alpha_d2',
        60);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('literacy',
        'prealpha',
        'Prealpha 1',
        'prealpha_1',
        40);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('literacy',
        'prealpha',
        'Prealpha 2',
        'prealpha_2',
        40);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'alpha_a',
        'Alpha A1',
        'alpha_a1',
        25);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'alpha_a',
        'Alpha A2',
        'alpha_a2',
        25);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'alpha_b',
        'Alpha B1',
        'alpha_b1',
        25);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'alpha_b',
        'Alpha B2',
        'alpha_b2',
        25);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'alpha_c',
        'Alpha C1',
        'alpha_c1',
        25);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'alpha_c',
        'Alpha C2',
        'alpha_c2',
        25);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'alpha_d',
        'Alpha D1',
        'alpha_d1',
        25);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'alpha_d',
        'Alpha D2',
        'alpha_d2',
        25);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'bravo_a',
        'Bravo A1',
        'bravo_a1',
        20);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'bravo_a',
        'Bravo A2',
        'bravo_a2',
        20);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'bravo_b',
        'Bravo B1',
        'bravo_b1',
        20);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'bravo_b',
        'Bravo B2',
        'bravo_b2',
        20);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'bravo_c',
        'Bravo C1',
        'bravo_c1',
        20);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'bravo_c',
        'Bravo C2',
        'bravo_c2',
        20);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'bravo_d',
        'Bravo D1',
        'bravo_d1',
        20);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'bravo_d',
        'Bravo D2',
        'bravo_d2',
        20);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'prealpha',
        'Prealpha 1',
        'prealpha_1',
        50);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'prealpha',
        'Prealpha 2',
        'prealpha_2',
        50);


INSERT INTO test_marks(module, course, test_name, test_id,testmaxscore)
VALUES ('numeracy',
        'prealpha',
        'Prealpha 3',
        'prealpha_3',
        50);

 /*config for grade 7 revision tests*/
INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test1',
       'Grade 7 - Average (mean)',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test2',
       'Grade 7 - Proportions and Ratios',
       'grade7_revision',
       'numeracy',
       35);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test3',
       'Grade 7 - Number Bases',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test4',
       'Grade 7 - Profit and Loss & Notation',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test5',
       'Grade 7 - Money and Percentage',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test6',
       'Grade 7 - Notation & Place Values',
       'grade7_revision',
       'numeracy',
       35);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test7',
       'Grade 7 - Equation, Factors, Negative Numbers',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test8',
       'Grade 7 - Area, Perimeter, Symmetry and Volume',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test9',
       'Grade 7 - Notation, Length and Shapes',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test10',
       'Grade 7 - Sets and Speed ',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test11',
       'Grade 7 - Word Problems: Notations',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test12',
       'Grade 7 - Bases, Roman Numerals and Graphs',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test13',
       'Grade 7 - Fractions',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_test14',
       'Grade 7 - Decimals',
       'grade7_revision',
       'numeracy',
       30);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_mock1',
       'Grade 7 - Mock 1',
       'grade7_revision',
       'numeracy',
       60);


INSERT INTO test_marks(test_id,test_name,course,module,testmaxscore)
VALUES('grade7_mock2',
       'Grade 7 - Mock 2',
       'grade7_revision',
       'numeracy',
       60);

 /*set test pass score to 75% for all tests */
UPDATE test_marks
SET test_pass_score = .75;

 /*add channel_id for each test*/
UPDATE test_marks
SET channel_id = '6380a6a9-8a4c-4b26-8b31-47ad1c7ada13'
WHERE course = 'prealpha'
  AND module = 'numeracy'
  AND test_id = 'prealpha_1';


UPDATE test_marks
SET channel_id = '20113bf1-ba07-4e08-bcc7-faaca03ade8a'
WHERE course = 'prealpha'
  AND module = 'numeracy'
  AND test_id = 'prealpha_2';


UPDATE test_marks
SET channel_id = '1700bf9e-7109-4857-abf3-6c04a1963004'
WHERE course = 'prealpha'
  AND module = 'numeracy'
  AND test_id = 'prealpha_3';


UPDATE test_marks
SET channel_id = '8784b9f7-8d58-4273-aff5-79b246529215'
WHERE course = 'alpha_a'
  AND module = 'numeracy';


UPDATE test_marks
SET channel_id = 'cc805378-86cb-498e-b564-242f44c87723'
WHERE course = 'alpha_b'
  AND module = 'numeracy';


UPDATE test_marks
SET channel_id= '7035e792-1ddf-489f-ad45-44c814a199fb'
WHERE course = 'alpha_c'
  AND module = 'numeracy';


UPDATE test_marks
SET channel_id = '1d8f1428-da33-4779-b956-85c4581186c4'
WHERE course = 'alpha_d'
  AND module = 'numeracy';


UPDATE test_marks
SET channel_id = '57995474-194c-4068-bfed-1ee16108093f'
WHERE course = 'bravo_a'
  AND module = 'numeracy';


UPDATE public.test_marks
SET channel_id = 'b7214b92-1fd9-4a1c-b758-821919bcd3e0'
WHERE course = 'bravo_b'
  AND module = 'numeracy';


UPDATE public.test_marks
SET channel_id = '5aee4435-135b-4039-a3a8-24d96f72bfcb'
WHERE course = 'bravo_c'
  AND module = 'numeracy';


UPDATE public.test_marks
SET channel_id = '98ab8048-1075-45da-92e3-394409955526'
WHERE course = 'bravo_d'
  AND module = 'numeracy';