const express = require('express')
const router = express.Router()
const path = require('path');

/*Use the public directory to serve static assets*/
router.use(express.static(path.resolve(
    path.join(__basedir, 'public')
)))

/*skills hub assessments page*/
router.get('/', (req, res) => {
    res.sendFile(path.resolve('skills_hub/index.html'));
});

/*skills hub math assessment*/
router.get('/math_assessment', (req, res) => {
    res.sendFile(path.resolve('skills_hub/math_assessment.html'));
});

/*skills hub literacy assessment*/
router.get('/literacy_assessment', (req, res) => {
    res.sendFile(path.resolve('skills_hub/literacy_assessment.html'));
});

module.exports = router 