-- Step 1: Create a new serial column
ALTER TABLE public.test_questions
    ADD COLUMN id SERIAL;

-- Step 2: Update the values of the new column with the values of the existing integer column
UPDATE
    public.test_questions
SET
    id = source_blquestion_id;

-- Step 3: Remove the existing integer column
ALTER TABLE public.test_questions
    DROP COLUMN source_blquestion_id;

-- Step 4: Rename the new serial column to match the name of the old integer column
ALTER TABLE public.test_questions RENAME COLUMN id TO source_blquestion_id;

ALTER TABLE public.test_questions
    ADD CONSTRAINT test_questions_pkey PRIMARY KEY (source_blquestion_id);

