const express = require('express')
const router = express.Router()
const path = require('path')
const url = require('url');

const { Pool, Client } = require('pg')

const pool = new Pool({
    user: process.env.BASELINE_DATABASE_USER,
    host: process.env.BASELINE_DATABASE_HOST,
    database: process.env.BASELINE_DATABASE_NAME,
    password: process.env.BASELINE_DATABASE_PASSWORD,
    port: process.env.BASELINE_DATABASE_PORT,
})

router.use(express.static(path.resolve('public')));

/*Return today as string*/
/*Used for timestamping of responses*/
const get_datetime_string = () => {
    let today = new Date()
    let dd = today.getDate()
    let mm = today.getMonth() + 1 //January is 0!
    let yyyy = today.getFullYear()

    /*prefix date with 0 if less than 10(for consisitency with central db)*/
    if (dd < 10) {
        dd = '0' + dd
    }

    /*prefix month with 0 if less than 10(for consisitency with central db)*/
    if (mm < 10) {
        mm = '0' + mm
    }
    /*return today's date as string*/
    today = yyyy + '-' + mm + '-' + dd
    return today
}


router.get('/get_server_date', (request, response) => {
    let current_date = get_datetime_string()
    return response.json(current_date)
});

router.get('/sucessful_submit', (request, response) => {
    path.join(__basedir, 'public')
    response.sendFile(path.join(__basedir, '/submit/sucessful_submission.html'));
});




/*endpoint to get users list as json*/
router.get('/get_users', async (request, response, next) => {
    const users_query = {
        /*Query to fetch all users*/
        name: 'fetch-users',
        text: 'select * from users'
    }

    try {
        const { rows } = await pool.query(users_query)
        response.status(200).send(rows)
    } catch (err) {
        console.log(err.stack)
    }

});


/*endpoint to get index_of_topics as json*/
router.get('/index_of_topics', (request, response, next) => {
    const topics_query = {
        /*Query to fetch all topics*/
        name: 'fetch-topics',
        text: 'SELECT * FROM index_of_topics'
    }


    pool.query(topics_query)
        .then(res => response.status(200).send(res.rows))
        .catch(e => console.log(e.stack))


});


/*endpoint to test count stats list as json*/
router.get('/get_test_count', (request, response, next) => {
    const test_counts_query = {
        /*Query to count the number of tests and group by month end (last day(test date))*/
        name: 'fetch-test-counts',
        text: 'SELECT last_day(test_date::date) as test_month, count(*) as number_of_tests from responses group by last_day(test_date::date) order by last_day(test_date::date) desc'
    }

    /*Run query and send the response back if sucessful*/
    pool.query(test_counts_query)
        .then(res => response.status(200).send(res.rows))
        /*Log any errors to the console if not successful*/
        .catch(e => console.log(e.stack))

});

/*endpoint to get learner count by class*/
router.get('/get_learners_count', async (request, response) => {
    /*Query to fetch all grades and total learners in the grade*/
    const classes = {
        name: 'fetch-classes',
        text: "select case when class_name is null then 'Unenrolled' else class_name end as class_name, class_total from (select class_name, count(*) class_total from users group by class_name) classes;"
    }

    /*return result query */
    var result = await pool.query(classes);

    /*store grades object in a variable*/
    var learner_classes = result.rows;

    /*array to store learner by count objects*/
    var leaerner_count_data = []

    /*get number of learners for each group in a given class */
    for (var i = 0; i < learner_classes.length; i++) {

        /**empty object to store details of groups for particular grade*/
        var learner_count_obj = {}

        /**return result query containing the number of learners for each group in a given class */
        var levels_result = await pool.query('SELECT * FROM get_learner_count($1)', [learner_classes[i].class_name]);

        /**store details of a group in an object*/
        learner_count_obj.class_total = learner_classes[i].class_total;
        learner_count_obj.class = learner_classes[i].class_name;
        learner_count_obj.levels = levels_result.rows;

        /**append the object to leaerner_count_data array */
        leaerner_count_data.push(learner_count_obj);
    }
    response.status(200).send(leaerner_count_data)

});

/*endpoint to get all test_responses as json*/
router.get('/get_responses', (request, response) => {
    const get_responses_query = {
        /*Query to fetch all the responses from the responses table and calculate the score percent for each one*/
        name: 'fetch-responses',
        text: 'select u.username,u.first_name,u.last_name,tm.test_name,r.*,round((coalesce(q1::integer,0.0)+ coalesce(q2::integer,0.0)+ coalesce(q3::integer,0.0)+ coalesce(q4::integer,0.0)+ coalesce(q5::integer,0.0)+ coalesce(q6::integer,0.0)+ coalesce(q7::integer,0.0)+ coalesce(q8::integer,0.0)+ coalesce(q9::integer,0.0)+ coalesce(q10::integer,0.0)+ coalesce(q11::integer,0.0)+ coalesce(q12::integer,0.0)+ coalesce(q13::integer,0.0)+ coalesce(q14::integer,0.0)+ coalesce(q15::integer,0.0)+ coalesce(q16::integer,0.0)+ coalesce(q17::integer,0.0)+ coalesce(q18::integer,0.0)+ coalesce(q19::integer,0.0)+ coalesce(q20::integer,0.0)+ coalesce(q21::integer,0.0)+ coalesce(q22::integer,0.0)+ coalesce(q23::integer,0.0)+ coalesce(q24::integer,0.0)+ coalesce(q25::integer,0.0)+ coalesce(q26::integer,0.0)+ coalesce(q27::integer,0.0)+ coalesce(q28::integer,0.0)+ coalesce(q29::integer,0.0)+ coalesce(q30::integer,0.0)+ coalesce(q31::integer,0.0)+ coalesce(q32::integer,0.0)+ coalesce(q33::integer,0.0)+ coalesce(q34::integer,0.0)+ coalesce(q35::integer,0.0)+ coalesce(q36::integer,0.0)+ coalesce(q37::integer,0.0)+ coalesce(q38::integer,0.0)+ coalesce(q39::integer,0.0)+ coalesce(q40::integer,0.0)+ coalesce(q41::integer,0.0)+ coalesce(q42::integer,0.0)+ coalesce(q43::integer,0.0)+ coalesce(q44::integer,0.0)+ coalesce(q45::integer,0.0)+ coalesce(q46::integer,0.0)+ coalesce(q47::integer,0.0)+ coalesce(q48::integer,0.0)+ coalesce(q49::integer,0.0)+ coalesce(q50::integer,0.0)+ coalesce(q51::integer,0.0)+ coalesce(q52::integer,0.0)+ coalesce(q53::integer,0.0)+ coalesce(q54::integer,0.0)+ coalesce(q55::integer,0.0)+ coalesce(q56::integer,0.0)+ coalesce(q57::integer,0.0)+ coalesce(q58::integer,0.0)+ coalesce(q59::integer,0.0)+ coalesce(q60::integer,0.0)+ coalesce(q61::integer,0.0)+ coalesce(q62::integer,0.0)+ coalesce(q63::integer,0.0)+ coalesce(q64::integer,0.0)+ coalesce(q65::integer,0.0)+ coalesce(q66::integer,0.0)+ coalesce(q67::integer,0.0)+ coalesce(q68::integer,0.0)+ coalesce(q69::integer,0.0)+ coalesce(q70::integer,0.0))/testmaxscore,2) as score_pct from responses r left join users u on r.user_id = u.user_id left join test_marks tm on r.test = tm.test_id and r.course = tm.course and r.module = tm.module order by test_date desc'
    }

    /*Callback returns status code and result of query*/
    pool.query(get_responses_query)
        .then(res => response.status(200).send(res.rows))
        .catch(e => console.log(e.stack))

});

router.get('/get_test_marks', (request, response) => {
    const test_marks_query = {
        name: 'fetch-test-marks',
        text: 'SELECT * from test_marks'
    }

    /*Callback returns status code and result of query*/
    pool.query(test_marks_query)
        .then(res => response.status(200).send(res.rows))
        .catch(e => console.log(e.stack))

});

router.get('/results_breakdown', async (request, response) => {
    const results_query = {
        nam: 'fetch-results-breakdown',
        text: "select * from vtestscorebytopic;"
    }
    const res = await pool.query(results_query);
    const res_rows = res.rows;

    /**Restructure the results breakdown data */
    var result = res_rows.reduce((acc, curr) => {
        let item = acc.find(
            (item) =>
            item.response_id === curr.response_id && item.user_id === curr.user_id && item.username === curr.username && item.test_name === curr.test_name && item.test_date === curr.test_date && item.module === curr.module && item.course == curr.course
        );

        if (item) {
            item.topic_details.push({
                topic_id: curr.topic_id,
                topic_name: curr.topic_name,
                topic_score: curr.topic_score,
                channel_name: curr.channel_name,
                channel_id: curr.channel_id,
                total_wt: curr.total_wt
            });
        } else {
            acc.push({
                response_id: curr.response_id,
                user_id: curr.user_id,
                username: curr.username,
                test_name: curr.test_name,
                test_date: curr.test_date,
                module: curr.module,
                course: curr.course,
                topic_details: [{
                    topic_id: curr.topic_id,
                    topic_name: curr.topic_name,
                    topic_score: curr.topic_score,
                    channel_name: curr.channel_name,
                    channel_id: curr.channel_id,
                    total_wt: curr.total_wt
                }, ],
            });
        }

        return acc;
    }, []);

    response.status(200).send(result)

});

router.post('/submit_test', [(request, response, next) => {

    /*simple function to sum values in an array*/
    const reducer = (accumulator, currentValue) => accumulator + Number(currentValue);

    /*Get the test response from the request body*/
    let test_resp = request.body

    console.log(test_resp)
    /*check if response was checkboxes
    will appear as array in response*/

    /*for each response recieved*/
    for (let v in test_resp) {
        /*if the reponse is of type object(array). Questions with a single response will be of type string*/
        if (typeof(test_resp[v]) == "object") {
            /*use reducer method to get sum of elements*/
            total = Object.values(test_resp[v]).reduce(reducer, 0)
            /*if the total is less than 0, make the response 0. Wrong responses have -1 mark, so will be negative total*/
            if (total <= 0) {
                test_resp[v] = '0'
            } else {
                /*if the total is not 0, then only the correct responses were selected. Assign value to 1*/
                test_resp[v] = '1'
            }
        } else {
            /*if only one correct response was selected, value will be partial marks. Partial marks are not allowed. Assign the value to 0*/
            if (Number(test_resp[v]) < 1) {
                test_resp[v] = '0'
            }
        }
    }

    /*properties of response object - user_id,username,q1,q2..*/
    let test_resp_props = Object.keys(test_resp)

    console.log(test_resp_props)

    /*Get user responses for test_resp_props above as array. Preserve quotes for insertion into database*/
    let uresponses = test_resp_props.map((v) => { return test_resp[v]; })

    console.log(uresponses)

    /*remove the test date from the reponse props*/
    /*let utest_date = uresponses.pop();*/

    let uresponses_quoted = "'" + uresponses.join("','") + "'"

    console.log(uresponses)

    /*Insert statement to run on database. test date added as current date from server*/

    let insert_statement = 'INSERT INTO responses(' + test_resp_props.toString() + ') values (' + uresponses_quoted + ')'
    console.log(insert_statement);

    // execute the query and return a promise
    pool.query(insert_statement)
        .then(result => {
            console.log("Promise returned: Test submited sucessfully!")
        })
        .catch(e => console.error(e.stack))
    next();
}, (request, response) => {
    /*Display successful submission page after request sucessful*/
    response.sendFile(path.join(__basedir, '/submit/sucessful_submission.html'));
}]);

/*An endpoint to delete a test based on user_id, test, course, module, and test date*/
router.post('/overwrite_test', [(request, response, next) => {
    /*get the test response from the request body*/
    let test_resp = request.body;

    /*Get the props which we will use as our criteria for deleting the existing test*/
    /*Before inserting the one which has just been submitted*/
    let user_id = test_resp.user_id
    let test_done = test_resp.test
    let course = test_resp.course
    let test_module = test_resp.module
    let test_date = test_resp.test_date

    /*Delete tests done by the same user in the same test, course, and module done on the same day*/
    let query_other = 'DELETE FROM responses where user_id=($1) and test=($2) and course=($3) and module=($4) and test_date=($5)'
    let values_other = [user_id, test_done, course, test_module, test_date]

    // callback
    pool.query(query_other, values_other, (err, res) => {
        if (err) {
            console.log(err.stack)
            response.status(400).send('Could not delete row(s)')
            res.end()
        }
    })
    /*send a status of 200 and a success message back to the client*/
    next();
}, (request, response) => {
    let success_message = "Sucessfully deleted row(s)"
    response.status(200).send(success_message)
    console.log(success_message)
}]);

/*Endpoint to assign learners when they log in to Kolibri*/
router.post("/kolibri_login", (request, response) => {
    /*Capture user details which arrive in the request body*/
    let user_details = request.body;

    /*Spawn a child process*/
    /*let spawn = require("child_process").spawn;*/
    /*Run the main file of the assign learners script*/
    /*Supply the username and facility of the user as sysarg values*/
    /*let process = spawn('python', ["./auto_assign_learners/main.py",
        user_details.username,
        user_details.facility
    ]);*/

    /*Log the output of the child process (print statements. errors not logged directly)*/
    /*process.stdout.on('data', function(data) {
        console.log(data.toString());
    });*/

    /*End the response. No need to send a response back to Kolibri*/
    response.end()
});

router.post('/submit_ext_eval', (request, response, next) => {

    let test_resp = request.body

    /*properties of response object - user_id,username,q1,q2..*/
    let test_resp_props = Object.keys(test_resp)

    console.log(test_resp)

    /*Get user responses for test_resp_props above as array. Preserve quotes for insertion into database*/
    let uresponses = test_resp_props.map((v) => { return test_resp[v]; })

    /*remove the test date from the reponse props*/
    /*let utest_date = uresponses.pop();*/

    let uresponses_quoted = "'" + uresponses.join("','") + "'"

    /*Insert statement to run on database. test date added as current date from server*/

    let insert_statement = 'INSERT INTO ext_eval_responses(' + test_resp_props.toString() + ') values (' + uresponses_quoted + ')'
    console.log(insert_statement);

    // promise
    pool.query(insert_statement)
        .then(res => {
            response.sendFile(path.join(__basedir, '/submit/sucessful_submission.html'))
            console.log("Promise returned: Evaluation   submited sucessfully!")
        })
        .catch(e => console.error(e.stack))
});


router.post('/submit_survey', (request, response, next) => {

    let test_resp = request.body

    /*properties of response object - user_id,username,q1,q2..*/
    let test_resp_props = Object.keys(test_resp)

    console.log(test_resp)

    /*Get user responses for test_resp_props above as array. Preserve quotes for insertion into database*/
    let uresponses = test_resp_props.map((v) => { return test_resp[v]; })

    /*remove the test date from the reponse props*/
    /*let utest_date = uresponses.pop();*/

    let uresponses_quoted = "'" + uresponses.join("','") + "'"

    /*Insert statement to run on database. test date added as current date from server*/

    let insert_statement = 'INSERT INTO survey_responses(' + test_resp_props.toString() + ') values (' + uresponses_quoted + ')'
    console.log(insert_statement);

    // promise
    pool.query(insert_statement)
        .then(res => {
            response.sendFile(path.join(__basedir, '/submit/sucessful_submission.html'))
            console.log("Promise returned: Survey submited sucessfully!")
        })
        .catch(e => console.error(e.stack))
});


/*Endpoint to check if a user is eligible to write a particular test*/
router.get('/user_testcheck', (request, response) => {
    /*parse the query params into an object*/
    let queryObject = url.parse(request.url, true).query;

    /*create a list containing the object props of interest*/
    /*these vars will be used as params in the query to the db*/
    let query_params = [queryObject.user_id, queryObject.test, queryObject.course, queryObject.module, queryObject.test_date];

    /*declare a query variable containing a parametized call to the user_testcheck function*/
    let testcheck_query = {
        /*Query to call function for test check*/
        name: 'check-user-test',
        text: 'SELECT * FROM user_testcheck($1,$2,$3,$4,$5)'
    }

    /*Make the query using the query text and params*/
    pool.query(testcheck_query, query_params)
        /*When sucessful, return a status code of 200 and the result set*/
        .then(res => response.status(200).send(res.rows[0]))
        /*Log any errors to the console*/
        .catch(e => console.log(e.stack))
});


module.exports = router