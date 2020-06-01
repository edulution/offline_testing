/*portal homepage*/
app.get('/',(req, res) => {
 res.sendFile( __dirname + '/portal/index.html');
});

/*numeracy assessments page*/
app.get('/numeracy_assessments', (req, res) => {
 res.sendFile( __dirname + '/portal/numeracy_assessments.html');
});

/*index of topics*/
app.get('/topics',(req, res) => {
 res.sendFile( __dirname + '/portal/topics-index.html');
});

app.get('/literacy_tests',(req, res) => {
 res.sendFile( __dirname + '/portal/literacy_tests.html');
});

/*Alpha playlists*/
app.get('/alpha_a',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/alpha/alpha_a.html');
});

app.get('/alpha_b',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/alpha/alpha_b.html');
});

app.get('/alpha_c',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/alpha/alpha_c.html');
});

app.get('/alpha_d',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/alpha/alpha_d.html');
});


/*Bravo Playlists*/
app.get('/bravo_a',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/bravo/bravo_a.html');
});

app.get('/bravo_b',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/bravo/bravo_b.html');
});

app.get('/bravo_c',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/bravo/bravo_c.html');
});

app.get('/bravo_d',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/bravo/bravo_d.html');
});

/*Pre-Alpha playlists*/
app.get('/prealpha_a',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/prealpha/prealpha_a.html');
});

app.get('/prealpha_b',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/prealpha/prealpha_b.html');
});

app.get('/prealpha_c',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/prealpha/prealpha_c.html');
});

app.get('/prealpha_d',(req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/prealpha/prealpha_d.html');
});



/*portal homepage*/
app.get('/', (req, res) => {
 res.sendFile( __dirname + '/portal/index.html');
});

/*index of topics*/
app.get('/topics', (req, res) => {
 res.sendFile( __dirname + '/portal/topics-index.html');
});

app.get('/literacy_tests', (req, res) => {
 res.sendFile( __dirname + '/portal/literacy_tests.html');
});

app.get('/grade_7_revision', (req, res) => {
 res.sendFile( __dirname + '/portal/grade_7_revision.html');
});

/*Alpha playlists*/
app.get('/alpha_a', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/alpha/alpha_a.html');
});

app.get('/alpha_b', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/alpha/alpha_b.html');
});

app.get('/alpha_c', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/alpha/alpha_c.html');
});

app.get('/alpha_d', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/alpha/alpha_d.html');
});


/*Bravo Playlists*/
app.get('/bravo_a', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/bravo/bravo_a.html');
});

app.get('/bravo_b', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/bravo/bravo_b.html');
});

app.get('/bravo_c', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/bravo/bravo_c.html');
});

app.get('/bravo_d', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/bravo/bravo_d.html');
});

/*Pre-Alpha playlists*/
app.get('/prealpha_a', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/prealpha/prealpha_a.html');
});

app.get('/prealpha_b', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/prealpha/prealpha_b.html');
});

app.get('/prealpha_c', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/prealpha/prealpha_c.html');
});

app.get('/prealpha_d', (req, res) => {
 res.sendFile( __dirname + '/portal/playlists/numeracy/prealpha/prealpha_d.html');
});
