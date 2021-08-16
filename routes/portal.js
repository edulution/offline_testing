const express = require('express');
const router = express.Router();
const path = require('path');

/* Use the public directory to serve static assets*/
router.use(express.static(path.resolve(
    path.join(__basedir, 'public')
)));

/* portal homepage*/
router.get('/', (req, res) => {
    res.status(200).sendFile(path.resolve('portal/index.html'));
});

/* numeracy assessments page*/
router.get('/numeracy_tests', (req, res) => {
    res.status(200).sendFile(path.resolve('portal/numeracy_tests.html'));
});

/* index of topics*/
router.get('/topics', (req, res) => {
    res.status(200).sendFile(path.resolve('portal/topics-index.html'));
});

/* literacy assessments page*/
router.get('/literacy_tests', (req, res) => {
    res.status(200).sendFile(path.resolve('portal/literacy_tests.html'));
});

/* grade7_revision page*/
router.get('/grade7_revision', (req, res) => {
    res.status(200).sendFile(path.resolve('portal/grade7_revision.html'));
});

/* external evaluations page*/
router.get('/external_evaluations', (req, res) => {
    res.status(200).sendFile(path.resolve('portal/external_evaluations.html'));
});

module.exports = router;