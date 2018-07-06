var express = require('express');
var app = express();
var path = require('path');

/*Por the server will run on*/
var port = 5000;

/*Use sqlite3 Database*/
const sqlite3 = require('sqlite3').verbose();

/*Use bodyParser to parse form data*/ 
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

/*Serve static assets from the public folder*/
app.use(express.static(path.join(__dirname,'public')));


/*Get users from csv file and store as arraylist*/
/*===========*/
/*require filestream and csv libraries*/
var fs = require('fs');
var csv = require('csv');

/*instantiate empty users array*/
var users = [];

/*read users csv file with headers*/
var readStream = fs.createReadStream(__dirname + '/users.csv.headers');

/*parse by columns and push objects to users array*/
var parser = csv.parse({columns:true});

parser.on('readable', function() {
  while(record = parser.read()) {
    users.push(record);
  }
});

/*log error messages*/
parser.on('error', function(err) {
  console.log(err.message);
});

/*log users array when finished sucessfully*/
parser.on('finish', (function() {
  console.log('successfully loaded '+ users.length + ' users from database...');
}));

readStream.pipe(parser);
/*=======*/

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


/*Results dashboard page*/
app.get('/results', function (req, res) {
 res.sendFile( __dirname + '/dashboard/index.html');
});

/*Urls for forms*/

/*Prealpha comp tests*/
app.get('/prealp_comp_1', function (req, res) {
 res.sendFile( __dirname + '/prealp_comp_1.html');
});

app.get('/prealp_comp_2', function (req, res) {
 res.sendFile( __dirname + '/prealp_comp_2.html');
});

app.get('/prealp_comp_3', function (req, res) {
 res.sendFile( __dirname + '/prealp_comp_3.html');
});


/*Alpha comp tests*/
app.get('/alp_comp_1', function (req, res) {
 res.sendFile( __dirname + '/alp_comp_1.html');
});

app.get('/alp_comp_2', function (req, res) {
 res.sendFile( __dirname + '/alp_comp_2.html');
});


/*Alpha sectional tests*/

/*Alpha section A*/
app.get('/alp_sec_a1', function (req, res) {
 res.sendFile( __dirname + '/alp_sec_a1.html');
});

app.get('/alp_sec_a2', function (req, res) {
 res.sendFile( __dirname + '/alp_sec_a2.html');
});


/*Alpha section B*/
app.get('/alp_sec_b1', function (req, res) {
 res.sendFile( __dirname + '/alp_sec_b1.html');
});

app.get('/alp_sec_b2', function (req, res) {
 res.sendFile( __dirname + '/alp_sec_b2.html');
});

/*Alpha section C*/
app.get('/alp_sec_c1', function (req, res) {
 res.sendFile( __dirname + '/alp_sec_c1.html');
});

app.get('/alp_sec_c2', function (req, res) {
 res.sendFile( __dirname + '/alp_sec_c2.html');
});

/*Alpha section D*/
app.get('/alp_sec_d1', function (req, res) {
 res.sendFile( __dirname + '/alp_sec_d1.html');
});

app.get('/alp_sec_d2', function (req, res) {
 res.sendFile( __dirname + '/alp_sec_d2.html');
});

/*endpoint to get users list as json*/
app.get('/get_users',function(req, res){
        return res.json(users);
});

/*endpoint to get all test_responses as json*/
app.get('/get_responses',function(req, res){
        let db = new sqlite3.Database(path.join(__dirname,'public/test_responses.sqlite'));
        var responses_query='select u.user_id,u.group_name,r.* from responses r join users u where r.username = u.username;';
        db.all(responses_query,function(err,rows){
        	/*console.log(rows);*/
        	return res.json(rows);
        });
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
	let db = new sqlite3.Database(path.join(__dirname,'public/test_responses.sqlite'));

	db.run(insert_statement);
	db.close();
	next();}
	, function(req,res){
		/*Display successful submission page after request sucessful*/
		res.sendFile( __dirname + '/sucessful_submission.html');
}]);

app.listen(process.env.PORT || 5000);
