// Script to apply the user_testcheck migration to disable test recommendations
const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');

const pool = new Pool({
    user: process.env.BASELINE_DATABASE_USER,
    host: process.env.BASELINE_DATABASE_HOST,
    database: process.env.BASELINE_DATABASE_NAME,
    password: process.env.BASELINE_DATABASE_PASSWORD,
    port: process.env.BASELINE_DATABASE_PORT,
});

async function applyMigration() {
    const sqlFilePath = path.join(__dirname, 'disable_test_recommendations.sql');
    const sql = fs.readFileSync(sqlFilePath, 'utf8');
    
    console.log('Applying migration to disable test recommendations...');
    
    try {
        await pool.query(sql);
        console.log('✅ Migration applied successfully!');
        console.log('Test recommendations are now disabled.');
    } catch (error) {
        console.error('❌ Error applying migration:', error);
        process.exit(1);
    } finally {
        await pool.end();
    }
}

applyMigration();
