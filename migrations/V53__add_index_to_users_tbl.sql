CREATE UNIQUE INDEX IF NOT EXISTS idx_user_id
    ON public.users USING btree
    (user_id ASC NULLS LAST)
    TABLESPACE pg_default;