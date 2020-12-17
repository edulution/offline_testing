CREATE TABLE public.course (
	module character varying NOT NULL, 
	course character varying NOT NULL, 
	sort_order integer, channel_id uuid, 
	PRIMARY KEY (module, course)) 

WITH (OIDS = FALSE);

/*config for courses*/
INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('literacy' ,
        'alpha_a',
        NULL,
        NULL);


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('literacy' ,
        'alpha_b',
        NULL,
        NULL);


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('literacy',
        'alpha_c',
        NULL,
        NULL);


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('literacy' ,
        'alpha_d',
        NULL,
        NULL);


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('literacy',
        'prealpha',
        NULL,
        NULL);


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('numeracy' ,
        'alpha_a',
        20,
        '8784b9f7-8d58-4273-aff5-79b246529215');


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('numeracy',
        'alpha_b',
        30,
        'cc805378-86cb-498e-b564-242f44c87723');


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('numeracy',
        'alpha_c',
        40,
        '7035e792-1ddf-489f-ad45-44c814a199fb');


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('numeracy',
        'alpha_d',
        50,
        '1d8f1428-da33-4779-b956-85c4581186c4');


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('numeracy',
        'bravo_a',
        60,
        '57995474-194c-4068-bfed-1ee16108093f');


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('numeracy',
        'bravo_b',
        70,
        'b7214b92-1fd9-4a1c-b758-821919bcd3e0');


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('numeracy' ,
        'bravo_c',
        80,
        '5aee4435-135b-4039-a3a8-24d96f72bfcb');


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('numeracy',
        'bravo_d',
        90,
        '98ab8048-1075-45da-92e3-394409955526');


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('numeracy',
        'prealpha',
        10,
        '1700bf9e-7109-4857-abf3-6c04a1963004');


INSERT INTO public.course(module, course, sort_order, channel_id)
VALUES ('numeracy',
        'grade7_revision',
        NULL,
        NULL);


/*add constraints linking course and test_marks*/
ALTER TABLE public.test_marks ADD CONSTRAINT fk_course_test
FOREIGN KEY (module,
             course) REFERENCES public.course (module, course) MATCH SIMPLE ON
UPDATE NO ACTION ON
DELETE NO ACTION;


ALTER TABLE public.course ADD CONSTRAINT uk_course_sort UNIQUE (module,
                                                                course,
                                                                sort_order) ;