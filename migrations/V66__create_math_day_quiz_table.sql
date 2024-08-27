/*Create responses table*/
CREATE TABLE public.math_day_quiz (
    response_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    test varchar,
    module varchar,
    username varchar,
    coach_id varchar,
    test_date DATE,
    q1 varchar,
    q2 varchar,
    q3 varchar,
    q4 varchar,
    q5 varchar,
    q6 varchar,
    q7 varchar,
    q8 varchar,
    q9 varchar,
    q10 varchar,
    q11 varchar,
    q12 varchar,
    q13 varchar,
    q14 varchar,
    q15 varchar,
    q16 varchar,
    q17 varchar,
    q18 varchar,
    q19 varchar,
    q20 varchar,
    q21 varchar,
    q22 varchar,
    q23 varchar,
    q24 varchar,
    q25 varchar,
    q26 varchar,
    q27 varchar,
    q28 varchar,
    q29 varchar,
    q30 varchar,
    course varchar,
    user_id uuid,
    sex varchar(1),
    grade varchar(1),
    gender varchar(1),
    FOREIGN KEY (user_id) REFERENCES public.users(user_id)
);
