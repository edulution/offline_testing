CREATE TABLE IF NOT EXISTS test_marks(
	test varchar unique not null,
	testmaxscore integer
);

insert into test_marks (test, testmaxscore) values ('alp_comp_1',50);
insert into test_marks (test, testmaxscore) values ('alp_comp_2',50);
insert into test_marks (test, testmaxscore) values ('alp_sec_a1',25);
insert into test_marks (test, testmaxscore) values ('alp_sec_a2',25);
insert into test_marks (test, testmaxscore) values ('alp_sec_b1',25);
insert into test_marks (test, testmaxscore) values ('alp_sec_b2',25);
insert into test_marks (test, testmaxscore) values ('alp_sec_c1',25);
insert into test_marks (test, testmaxscore) values ('alp_sec_c2',25);
insert into test_marks (test, testmaxscore) values ('alp_sec_d1',25);
insert into test_marks (test, testmaxscore) values ('alp_sec_d2',25);
insert into test_marks (test, testmaxscore) values ('prealp_comp_1',50);
insert into test_marks (test, testmaxscore) values ('prealp_comp_2',50);
insert into test_marks (test, testmaxscore) values ('prealp_comp_3',50);
insert into test_marks (test, testmaxscore) values ('lit_alp_a1',50);
insert into test_marks (test, testmaxscore) values ('lit_alp_a2',50);
insert into test_marks (test, testmaxscore) values ('lit_alp_b1',50);
insert into test_marks (test, testmaxscore) values ('lit_alp_b2',50);
insert into test_marks (test, testmaxscore) values ('lit_alp_c1',50);
insert into test_marks (test, testmaxscore) values ('lit_alp_c2',50);
insert into test_marks (test, testmaxscore) values ('lit_alp_d1',60);
insert into test_marks (test, testmaxscore) values ('lit_alp_d2',60);
insert into test_marks (test, testmaxscore) values ('lit_prealp_1',40);
insert into test_marks (test, testmaxscore) values ('lit_prealp_2',40);

-- for prod change get_responses query to:
-- 'select u.user_id,u.group_name,((ifnull(q1,0.0)+ ifnull(q2,0.0)+ ifnull(q3,0.0)+ ifnull(q4,0.0)+ ifnull(q5,0.0)+ ifnull(q6,0.0)+ ifnull(q7,0.0)+ ifnull(q8,0.0)+ ifnull(q9,0.0)+ ifnull(q10,0.0)+ ifnull(q11,0.0)+ ifnull(q12,0.0)+ ifnull(q13,0.0)+ ifnull(q14,0.0)+ ifnull(q15,0.0)+ ifnull(q16,0.0)+ ifnull(q17,0.0)+ ifnull(q18,0.0)+ ifnull(q19,0.0)+ ifnull(q20,0.0)+ ifnull(q21,0.0)+ ifnull(q22,0.0)+ ifnull(q23,0.0)+ ifnull(q24,0.0)+ ifnull(q25,0.0)+ ifnull(q26,0.0)+ ifnull(q27,0.0)+ ifnull(q28,0.0)+ ifnull(q29,0.0)+ ifnull(q30,0.0)+ ifnull(q31,0.0)+ ifnull(q32,0.0)+ ifnull(q33,0.0)+ ifnull(q34,0.0)+ ifnull(q35,0.0)+ ifnull(q36,0.0)+ ifnull(q37,0.0)+ ifnull(q38,0.0)+ ifnull(q39,0.0)+ ifnull(q40,0.0)+ ifnull(q41,0.0)+ ifnull(q42,0.0)+ ifnull(q43,0.0)+ ifnull(q44,0.0)+ ifnull(q45,0.0)+ ifnull(q46,0.0)+ ifnull(q47,0.0)+ ifnull(q48,0.0)+ ifnull(q49,0.0)+ ifnull(q50,0.0)+ ifnull(q51,0.0)+ ifnull(q52,0.0)+ ifnull(q53,0.0)+ ifnull(q54,0.0)+ ifnull(q55,0.0)+ ifnull(q56,0.0)+ ifnull(q57,0.0)+ ifnull(q58,0.0)+ ifnull(q59,0.0)+ ifnull(q60,0.0)+ ifnull(q61,0.0)+ ifnull(q62,0.0)+ ifnull(q63,0.0)+ ifnull(q64,0.0)+ ifnull(q65,0.0)+ ifnull(q66,0.0)+ ifnull(q67,0.0)+ ifnull(q68,0.0)+ ifnull(q69,0.0)+ ifnull(q70,0.0))/testmaxscore) as score_pct, r.*from responses r join test_marks tm on r.test = tm.test join users u on r.username = u.username'