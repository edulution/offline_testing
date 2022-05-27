CREATE INDEX IF NOT EXISTS idx_user_test_course_module
    ON public.responses USING btree
    (user_id ASC NULLS LAST, test COLLATE pg_catalog."default" ASC NULLS LAST, course COLLATE pg_catalog."default" ASC NULLS LAST, module COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;