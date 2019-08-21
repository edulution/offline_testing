/*create test marks table*/
/*primary key on (test_id,course,module)*/
CREATE TABLE IF NOT EXISTS test_marks(
	test_id varchar,
	test_name varchar,
	course varchar,
	module varchar,
	testmaxscore integer,
	PRIMARY KEY (test_id,course,module)
);

/*populate test marks with new config*/
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_a','Alpha A1','alpha_a1',50);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_a','Alpha A2','alpha_a2',50);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_b','Alpha B1','alpha_b1',50);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_b','Alpha B2','alpha_b2',50);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_c','Alpha C1','alpha_c1',50);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_c','Alpha C2','alpha_c2',50);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_d','Alpha D1','alpha_d1',60);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_d','Alpha D2','alpha_d2',60);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','prealpha','Prealpha 1','prealpha_1',40);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','prealpha','Prealpha 2','prealpha_2',40);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_a','Alpha A1','alpha_a1',25);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_a','Alpha A2','alpha_a2',25);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_b','Alpha B1','alpha_b1',25);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_b','Alpha B2','alpha_b2',25);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_c','Alpha C1','alpha_c1',25);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_c','Alpha C2','alpha_c2',25);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_d','Alpha D1','alpha_d1',25);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_d','Alpha D2','alpha_d2',25);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_a','Bravo A1','bravo_a1',20);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_a','Bravo A2','bravo_a2',20);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_b','Bravo B1','bravo_b1',20);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_b','Bravo B2','bravo_b2',20);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_c','Bravo C1','bravo_c1',20);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_c','Bravo C2','bravo_c2',20);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_d','Bravo D1','bravo_d1',20);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_d','Bravo D2','bravo_d2',20);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','prealpha','Prealpha 1','prealpha_1',50);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','prealpha','Prealpha 2','prealpha_2',50);
insert or ignore into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','prealpha','Prealpha 3','prealpha_3',50);