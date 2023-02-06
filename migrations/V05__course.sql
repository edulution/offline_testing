CREATE TABLE public.course (
	module character varying NOT NULL, 
	course character varying NOT NULL, 
	sort_order integer, channel_id uuid, 
	PRIMARY KEY (module, course)) 

WITH (OIDS = FALSE);