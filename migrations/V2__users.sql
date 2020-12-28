/*add uuid extension if it does not exist*/
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

/*Create the Users table*/
CREATE TABLE users (
    user_id uuid PRIMARY KEY,
    username varchar,
    group_name varchar,
    first_name varchar,
    last_name varchar
);
