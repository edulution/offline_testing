/*turn user_id into uuid*/

alter table responses
drop constraint responses_user_id_fkey

alter table users
drop constraint users_pkey

alter table users
alter column user_id type uuid using user_id::uuid

alter table responses
alter column user_id type uuid using user_id::uuid


alter table users add CONSTRAINT users_pkey PRIMARY KEY (user_id);

alter table responses add CONSTRAINT responses_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;



