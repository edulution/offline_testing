-- Add response_id to the responses table
-- Add primary key constraint to the table using this column
ALTER TABLE responses
ADD COLUMN response_id uuid PRIMARY KEY DEFAULT uuid_generate_v4();
