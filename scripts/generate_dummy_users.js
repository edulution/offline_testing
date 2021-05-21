const faker = require('faker');

const { Pool, Client } = require('pg')

const { v4: uuidv4 } = require('uuid');

const pool = new Pool({
    user: process.env.BASELINE_DATABASE_USER,
    host: process.env.BASELINE_DATABASE_HOST,
    database: process.env.BASELINE_DATABASE_NAME,
    password: process.env.BASELINE_DATABASE_PASSWORD,
    port: process.env.BASELINE_DATABASE_PORT,
})

/*Number of fake users to generate on baseline*/
const num_fakes = 5

/*Tell the user the number of fake users that will be generated*/
console.log(`Generating ${num_fakes} fake users for baseline`)

/*Loop to generate fakes*/
for (let i = 0; i < num_fakes; i++) {
    /*Template query to insert into users table*/
    const text = 'INSERT INTO users(user_id, first_name, last_name, username) VALUES($1, $2, $3, $4) RETURNING *'

    /*Generate fake user_id, first_name, last_name, username*/
    const values = [uuidv4(), faker.name.firstName(), faker.name.lastName(), faker.internet.userName()]

    /*Insert the generated fake into the database*/
    pool.query(text, values, (err, res) => {
        if (err) {
            console.log(err.stack)
        } /*else {
    console.log(res.rows[0])
}*/
    })
}

/*Close the pool connection and echo a sucess message*/
pool.end().then(() => console.log('Done!'))