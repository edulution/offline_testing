var express = require('express');
var app = express();
var path = require('path');

/*Por the server will run on*/
var port = 8888;

/*Use sqlite3 Database*/
const sqlite3 = require('sqlite3').verbose();

/*Use bodyParser to parse form data*/ 
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

/*Serve static assets from the public folder*/
app.use(express.static(path.join(__dirname,'public')));

/*Return today as string*/
/*Used for timestamping of responses*/
function get_datetime_string() {
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();

	/*prefix date with 0 if less than 10(for consisitency with central db)*/
	if(dd<10) {
	    dd = '0'+dd
	} 

	/*prefix month with 0 if less than 10(for consisitency with central db)*/
	if(mm<10) {
	    mm = '0'+mm
	}
	/*return today's date as string*/
	today = yyyy + '-' + mm + '-' + dd;
	return today;

}


/*Results dashboard page*/
app.get('/coach', function (req, res) {
 res.sendFile( __dirname + '/dashboard/index.html');
});


/*Numeracy prealpha tests*/
app.get('/num_prealpha_1', function (req, res) {
 res.sendFile( __dirname + '/numeracy/prealpha_1.html');
});

app.get('/num_prealpha_2', function (req, res) {
 res.sendFile( __dirname + '/numeracy/prealpha_2.html');
});

app.get('/num_prealpha_3', function (req, res) {
 res.sendFile( __dirname + '/numeracy/prealpha_3.html');
});


/*Alpha course family
/*Alpha A tests*/
app.get('/num_alpha_a1', function (req, res) {
 res.sendFile( __dirname + '/numeracy/alpha_a1.html');
});

app.get('/num_alpha_a2', function (req, res) {
 res.sendFile( __dirname + '/numeracy/alpha_a2.html');
});


/*Alpha B tests*/
app.get('/num_alpha_b1', function (req, res) {
 res.sendFile( __dirname + '/numeracy/alpha_b1.html');
});

app.get('/num_alpha_b2', function (req, res) {
 res.sendFile( __dirname + '/numeracy/alpha_b2.html');
});

/*Alpha C tests*/
app.get('/num_alpha_c1', function (req, res) {
 res.sendFile( __dirname + '/numeracy/alpha_c1.html');
});

app.get('/num_alpha_c2', function (req, res) {
 res.sendFile( __dirname + '/numeracy/alpha_c2.html');
});

/*Alpha D tests*/
app.get('/num_alpha_d1', function (req, res) {
 res.sendFile( __dirname + '/numeracy/alpha_d1.html');
});

app.get('/num_alpha_d2', function (req, res) {
 res.sendFile( __dirname + '/numeracy/alpha_d2.html');
});


/*Bravo course family

/*Bravo A tests*/
app.get('/num_bravo_a1', function (req, res) {
 res.sendFile( __dirname + '/numeracy/bravo_a1.html');
});

app.get('/num_bravo_a2', function (req, res) {
 res.sendFile( __dirname + '/numeracy/bravo_a2.html');
});

/*Bravo B tests*/
app.get('/num_bravo_b1', function (req, res) {
 res.sendFile( __dirname + '/numeracy/bravo_b1.html');
});

app.get('/num_bravo_b2', function (req, res) {
 res.sendFile( __dirname + '/numeracy/bravo_b2.html');
});

/*Bravo C tests*/
app.get('/num_bravo_c1', function (req, res) {
 res.sendFile( __dirname + '/numeracy/bravo_c1.html');
});

app.get('/num_bravo_c2', function (req, res) {
 res.sendFile( __dirname + '/numeracy/bravo_c2.html');
});

/*Bravo D tests*/
app.get('/num_bravo_d1', function (req, res) {
 res.sendFile( __dirname + '/numeracy/bravo_d1.html');
});


/*Litercy tests*/
app.get('/lit_alpha_a1', function (req, res) {
 res.sendFile( __dirname + '/literacy/alpha_a1.html');
});

app.get('/lit_alpha_a2', function (req, res) {
 res.sendFile( __dirname + '/literacy/alpha_a2.html');
});

app.get('/lit_alpha_b1', function (req, res) {
 res.sendFile( __dirname + '/literacy/alpha_b1.html');
});

app.get('/lit_alpha_b2', function (req, res) {
 res.sendFile( __dirname + '/literacy/alpha_b2.html');
});

app.get('/lit_alpha_c1', function (req, res) {
 res.sendFile( __dirname + '/literacy/alpha_c1.html');
});

app.get('/lit_alpha_c2', function (req, res) {
 res.sendFile( __dirname + '/literacy/alpha_c2.html');
});

app.get('/lit_alpha_d1', function (req, res) {
 res.sendFile( __dirname + '/literacy/alpha_d1.html');
});

app.get('/lit_alpha_d2', function (req, res) {
 res.sendFile( __dirname + '/literacy/alpha_d2.html');
});

app.get('/lit_prealpha_1', function (req, res) {
 res.sendFile( __dirname + '/literacy/prealpha_1.html');
});

app.get('/lit_prealpha_2', function (req, res) {
 res.sendFile( __dirname + '/literacy/prealpha_2.html');
});


app.get('/get_server_date', function (req, res) {
	var current_date = get_datetime_string()
	return res.json(current_date)
});

/*app.get('/ngsub', function (req, res) {
 res.sendFile( __dirname + '/numeracy/test_submit.html');
});*/


app.get('/sucessful_submit', function (req, res) {
 res.sendFile( __dirname + '/submit/sucessful_submission.html');
});

/*endpoint to get users list as json*/
app.get('/get_users',function(req, res){
        let db = new sqlite3.Database(path.join(__dirname,'public/test_responses.sqlite'));
        var responses_query='select * from users';
        db.all(responses_query,function(err,rows){
        	console.log('Retrieved '+rows.length+' users from the database');
        	return res.json(rows);
        });
});

/*endpoint to get all test_responses as json*/
/*modified responses query to join on course, test and module for new config*/
app.get('/get_responses',function(req, res){
        let db = new sqlite3.Database(path.join(__dirname,'public/test_responses.sqlite'));
        var responses_query='select u.username,u.first_name,u.last_name,tm.test_name,((ifnull(q1,0.0)+ ifnull(q2,0.0)+ ifnull(q3,0.0)+ ifnull(q4,0.0)+ ifnull(q5,0.0)+ ifnull(q6,0.0)+ ifnull(q7,0.0)+ ifnull(q8,0.0)+ ifnull(q9,0.0)+ ifnull(q10,0.0)+ ifnull(q11,0.0)+ ifnull(q12,0.0)+ ifnull(q13,0.0)+ ifnull(q14,0.0)+ ifnull(q15,0.0)+ ifnull(q16,0.0)+ ifnull(q17,0.0)+ ifnull(q18,0.0)+ ifnull(q19,0.0)+ ifnull(q20,0.0)+ ifnull(q21,0.0)+ ifnull(q22,0.0)+ ifnull(q23,0.0)+ ifnull(q24,0.0)+ ifnull(q25,0.0)+ ifnull(q26,0.0)+ ifnull(q27,0.0)+ ifnull(q28,0.0)+ ifnull(q29,0.0)+ ifnull(q30,0.0)+ ifnull(q31,0.0)+ ifnull(q32,0.0)+ ifnull(q33,0.0)+ ifnull(q34,0.0)+ ifnull(q35,0.0)+ ifnull(q36,0.0)+ ifnull(q37,0.0)+ ifnull(q38,0.0)+ ifnull(q39,0.0)+ ifnull(q40,0.0)+ ifnull(q41,0.0)+ ifnull(q42,0.0)+ ifnull(q43,0.0)+ ifnull(q44,0.0)+ ifnull(q45,0.0)+ ifnull(q46,0.0)+ ifnull(q47,0.0)+ ifnull(q48,0.0)+ ifnull(q49,0.0)+ ifnull(q50,0.0)+ ifnull(q51,0.0)+ ifnull(q52,0.0)+ ifnull(q53,0.0)+ ifnull(q54,0.0)+ ifnull(q55,0.0)+ ifnull(q56,0.0)+ ifnull(q57,0.0)+ ifnull(q58,0.0)+ ifnull(q59,0.0)+ ifnull(q60,0.0)+ ifnull(q61,0.0)+ ifnull(q62,0.0)+ ifnull(q63,0.0)+ ifnull(q64,0.0)+ ifnull(q65,0.0)+ ifnull(q66,0.0)+ ifnull(q67,0.0)+ ifnull(q68,0.0)+ ifnull(q69,0.0)+ ifnull(q70,0.0))/testmaxscore) as score_pct, r.* from responses r  left join users u  on r.user_id = u.user_id left join test_marks tm  on r.test = tm.test_id and r.course = tm.course and r.module = tm.module order by test_date desc';
        db.all(responses_query,function(err,rows){
        	/*console.log(rows);*/
        	return res.json(rows);
        });
});

/*endpoint to get a count of all test_responses as json*/
app.get('/get_test_count',function(req, res){
        let db = new sqlite3.Database(path.join(__dirname,'public/test_responses.sqlite'));
        var count_query="SELECT date(test_date,'start of month','+1 month','-1 day') as test_month, count(*) as number_of_tests from responses group by date(test_date,'start of month','+1 month','-1 day') order by date(test_date,'start of month','+1 month','-1 day') desc";
        db.all(count_query,function(err,rows){
        	/*console.log(rows);*/
        	return res.json(rows);
        });
});


app.post('/submit_test', [function(req, res,next){
	/*simple function to sum values in an array*/
	const reducer = (accumulator, currentValue) => accumulator + Number(currentValue);
		
	response = req.body;
	/*check if respponse response was checkboxes
	will appear as array in response*/

	/*for each response recieved*/
	for (v in response){
		/*if the reponse is of type object(array). Questions with a single response will be of type string*/
	  if (typeof(response[v]) == "object"){
	  	/*use reducer method to get sum of elements*/
	  	/*create array from values of responses with checkboxes*/
	  	var dataArray = Object.keys(response[v]).map(function(k){return response[v][k]})
	   total = dataArray.reduce(reducer,0)
	   /*if the total is less than 0, make the response 0. Wrong responses have -1 mark, so will be negative total*/
	   if(total <= 0){
	    response[v] = '0'
	   }
	   else{
	   	/*if the total is not 0, then only the correct responses were selected. Assign value to 1*/
	    response[v] = '1'
	   }
	  }
	  else {
	  	/*if only one correct response was selected, value will be partial marks. Partial marks are not allowed. Assign the value to 0*/
	  	if(Number(response[v])<1){
	  		response[v] = '0'
	  	}
	  }
	}

	/*Open database and run insert satement. Then close database*/
	let db = new sqlite3.Database(path.join(__dirname,'public/test_responses.sqlite'));

	/*get user id from username*/
	/*var get_user_id_query = "(select user_id from users where username ="+"'"+response['username']+"')";*/

	/*var get_user_id_query = "'"+response['user_id']+"'";*/

	/*properties of response object - user_id,username,q1,q2..*/
	var response_props = Object.keys(response);

	/*Get user responses for response_props above as array. Preserve quotes for insertion into database*/
	var uresponses = response_props.map(function(v) { return response[v]; });
	var uresponses_quoted = "'" + uresponses.join("','") + "'";


	/*put quotes around user_id*/
	
	db.serialize(function() {
        /*var insert_statement = 'INSERT INTO responses('+response_props.toString()+',test_date) values ('+uresponses_quoted+','+get_datetime_string()+')';*/
        var insert_statement = 'INSERT INTO responses('+response_props.toString()+') values ('+uresponses_quoted+')';
        console.log(insert_statement);

        db.run(insert_statement);
        db.close();
	});

	/*Get questions answered as array*/


	/*Insert statement to run on database. test date added as current date from server*/	
	next();}
	, function(req,res){
		/*Display successful submission page after request sucessful*/
		res.sendFile( __dirname + '/submit/sucessful_submission.html');
}]);

app.listen(port, '0.0.0.0', function() {
 console.log('Server running on port ' + port);
});