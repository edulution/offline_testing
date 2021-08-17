const supertest = require('supertest');
const should = require('should');

const server = supertest.agent('http://localhost:8888');

describe('Test portal', () => {
    /*Return the portal homepage*/
    it('Returns the portal home page', (done) => {
        server
            .get('/')
            .expect('Content-Type', /html/)
            .expect(200, done)
    });

    /*Return the numeracy tests page*/
    it('Returns the numeracy tests page', (done) => {
        server
            .get('/numeracy_tests')
            .expect('Content-Type', /html/)
            .expect(200, done)
    });

    /*Return the numeracy tests page*/
    it('Returns the grade 7 revision tests page', (done) => {
        server
            .get('/grade7_revision')
            .expect('Content-Type', /html/)
            .expect(200, done)
    });

    /*Return the numeracy tests page*/
    it('Returns the literacy tests page', (done) => {
        server
            .get('/literacy_tests')
            .expect('Content-Type', /html/)
            .expect(200, done)
    });


});