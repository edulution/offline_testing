/*create test marks table*/
/*primary key on (test_id,course,module)*/
/*Add composite key to test marks table*/
CREATE TABLE test_marks (
    test_id varchar,
    test_name varchar,
    course varchar,
    module varchar,
    testmaxscore integer,
    PRIMARY KEY(test_id, course, module)
);

/*populate test marks with new config*/
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_a','Alpha A1','alpha_a1',50);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_a','Alpha A2','alpha_a2',50);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_b','Alpha B1','alpha_b1',50);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_b','Alpha B2','alpha_b2',50);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_c','Alpha C1','alpha_c1',50);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_c','Alpha C2','alpha_c2',50);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_d','Alpha D1','alpha_d1',60);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','alpha_d','Alpha D2','alpha_d2',60);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','prealpha','Prealpha 1','prealpha_1',40);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('literacy','prealpha','Prealpha 2','prealpha_2',40);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_a','Alpha A1','alpha_a1',25);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_a','Alpha A2','alpha_a2',25);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_b','Alpha B1','alpha_b1',25);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_b','Alpha B2','alpha_b2',25);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_c','Alpha C1','alpha_c1',25);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_c','Alpha C2','alpha_c2',25);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_d','Alpha D1','alpha_d1',25);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','alpha_d','Alpha D2','alpha_d2',25);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_a','Bravo A1','bravo_a1',20);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_a','Bravo A2','bravo_a2',20);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_b','Bravo B1','bravo_b1',20);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_b','Bravo B2','bravo_b2',20);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_c','Bravo C1','bravo_c1',20);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_c','Bravo C2','bravo_c2',20);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_d','Bravo D1','bravo_d1',20);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','bravo_d','Bravo D2','bravo_d2',20);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','prealpha','Prealpha 1','prealpha_1',50);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','prealpha','Prealpha 2','prealpha_2',50);
insert into test_marks(module, course, test_name, test_id,testmaxscore) values ('numeracy','prealpha','Prealpha 3','prealpha_3',50);

# grade 7 revision tests
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test1','Grade 7 - Average (mean)','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test2','Grade 7 - Proportions and Ratios','grade7_revision','numeracy',35);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test3','Grade 7 - Number Bases','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test4','Grade 7 - Profit and Loss & Notation','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test5','Grade 7 - Money and Percentage','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test6','Grade 7 - Notation & Place Values','grade7_revision','numeracy',35);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test7','Grade 7 - Equation, Factors, Negative Numbers','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test8','Grade 7 - Area, Perimeter, Symmetry and Volume','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test9','Grade 7 - Notation, Length and Shapes','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test10','Grade 7 - Sets and Speed ','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test11','Grade 7 - Word Problems: Notations','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test12','Grade 7 - Bases, Roman Numerals and Graphs','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test13','Grade 7 - Fractions','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test14','Grade 7 - Decimals','grade7_revision','numeracy',30);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_mock1','Grade 7 - Mock 1','grade7_revision','numeracy',60);
insert into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_mock2','Grade 7 - Mock 2','grade7_revision','numeracy',60);
