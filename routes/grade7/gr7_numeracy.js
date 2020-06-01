const express = require('express')
const router = express.Router()
const path = require('path');

/*Use the public directory to serve static assets*/
router.use(express.static(path.resolve('public'))); 

/*Get the selected test as a param of the request*/
/*then construct the path to the html file*/
/*It is assumed that the name of the html file is the same as the requested test*/
router.get('/:test', (req, res) => {
	selected_test = req.params.test
	res.sendFile( path.resolve('grade_7/numeracy/'+ selected_test + '.html'));
});

module.exports = router;

/*Grade 7 revision*/

/*grade 7 mock tests*/
/*app.get('/gr7_mock1', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_mock1.html');
});
app.get('/gr7_mock2', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_mock2.html');
});

app.get('/gr7_test1', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test1.html');
});

app.get('/gr7_test2', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test2.html');
});

app.get('/gr7_test3', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test3.html');
});

app.get('/gr7_test4', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test4.html');
});

app.get('/gr7_test5', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test5.html');
});

app.get('/gr7_test6', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test6.html');
});

app.get('/gr7_test7', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test7.html');
});

app.get('/gr7_test8', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test8.html');
});

app.get('/gr7_test9', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test9.html');
});

app.get('/gr7_test10', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test10.html');
});

app.get('/gr7_test11', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test11.html');
});

app.get('/gr7_test12', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test12.html');
});

app.get('/gr7_test13', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test13.html');
});

app.get('/gr7_test14', (req, res) => {
 res.sendFile( __dirname + '/grade_7/grade7_test14.html');
});
*/