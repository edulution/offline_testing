const express = require('express')
const app = express()
const path = require('path')

const cors = require('cors')
app.use(cors())

/*Port the server will run on*/
const port = 8888

/*Use bodyParser to parse form data*/
const bodyParser = require('body-parser')
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }))

/*Serve static assets from the public folder*/
global.__basedir = __dirname;
app.use(express.static(path.join(__dirname, 'public')))

/*Import all of the route modules*/
const portal = require('./routes/portal')
const api = require('./routes/api')
const playlists = require('./routes/playlists')
const numeracy = require('./routes/numeracy')
const literacy = require('./routes/literacy')
const grade7 = require('./routes/grade7')
const surveys = require('./routes/surveys')
const coach_training = require('./routes/training')

app.use('/', portal)
app.use('/api', api)
app.use('/playlists', playlists)
app.use('/numeracy', numeracy)
/*app.use('/literacy', literacy)*/
app.use('/grade7', grade7)
app.use('/coach_training', coach_training)
app.use('/surveys', surveys)

/*Results dashboard page*/
app.get('/coach', (req, res) => {
    res.sendFile(__dirname + '/dashboard/index.html')
})

app.listen(port, '0.0.0.0', () => {
    console.log('Server running on port ' + port)
})