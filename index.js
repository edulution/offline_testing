var express = require('express');
var app = express();

/*Por the server will run on*/
var port = 8888;

/*Use sqlite3 Database*/
const sqlite3 = require('sqlite3').verbose();

/*Use bodyParser to parse form data*/ 
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

/*Serve static assets from the public folder*/
app.use(express.static('public'));

/*Get today's date in the form yyyy-mm-dd*/
var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!
var yyyy = today.getFullYear();

if(dd<10) {
    dd = '0'+dd
} 

if(mm<10) {
    mm = '0'+mm
} 

/*Return today as string*/
today = "'"+ yyyy + '-' + mm + '-' + dd +"'";


/*Single form for demonstration. Loaded when root of server requested*/
app.get('', function (req, res) {
 res.sendFile( __dirname + '/form1.html');
});


app.post('/submit_test', [function(req, res,next){
	/*Get questions answered as array*/
	var questions = Object.keys(req.body);

	/*Get answers for questions above as array. Preserve quotes for insertion into database*/
	var answers = questions.map(function(v) { return req.body[v]; });
	var answers_quoted = "'" + answers.join("','") + "'";

	/*Insert statement to run on database. test date added as current date from server*/
	var insert_statement = 'INSERT INTO responses('+questions.toString()+',test_date) values ('+answers_quoted+','+today+')';
	console.log(insert_statement);

	/*Open database and run insert satement. Then close database*/
	let db = new sqlite3.Database('public/test_responses.sqlite');
	db.run(insert_statement);
	db.close();
	next();}
	, function(req,res){
		/*Display successful submission page after request sucessful*/
		res.sendFile( __dirname + '/sucessful_submission.html');
}]);

app.listen(port, '0.0.0.0', function() {
 console.log('Server running at port ' + port);
});
