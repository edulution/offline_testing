const supertest = require('supertest');
const should = require('should');

/*Set the starting point to /api*/
const server = supertest.agent('http://localhost:8888/api');

describe('Test API endpoints', () => {
    /*Return the server date homepage*/
    it('Returns the current server date', (done) => {
        server
            .get('/get_server_date')
            .expect('Content-Type', /json/)
            .expect(200, done)
    });

});