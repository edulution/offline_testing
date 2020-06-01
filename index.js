const express = require('express');
const app = express();
const path = require('path');

/*Port the server will run on*/
const port = 8888;

/*Use bodyParser to parse form data*/ 
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

/*Serve static assets from the public folder*/
app.use(express.static(path.join(__dirname,'public'))); 

/*const global.__basedir = __dirname;*/

const api = require('./routes/api.js')
const numeracy = require('./routes/numeracy.js')
const literacy = require('./routes/literacy.js')
const gr7_numeracy = require('./routes/grade7/gr7_numeracy.js')

app.use('/numeracy', numeracy);
app.use('/literacy', literacy);
app.use('/grade7_numeracy', gr7_numeracy);


/*portal homepage*/
app.get('/',(req, res) => {
 res.sendFile( __dirname + '/portal/index.html');
});

/*Results dashboard page*/
app.get('/coach', (req, res) => {
 res.sendFile( __dirname + '/dashboard/index.html');
});

app.listen(port, '0.0.0.0', () => {
 console.log('Server running on port ' + port);
});
