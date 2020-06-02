const express = require('express')
const router = express.Router()
const path = require('path');

/*Use the public directory to serve static assets*/
router.use(express.static(path.resolve('public')));

/*Get the selected test as a param of the request*/
/*then construct the path to the html file*/
/*It is assumed that the name of the html file is the same as the requested test*/
router.get('/:course/:playlist', (req, res) => {
    let selected_course = req.params.course
    let selected_playlist = req.params.playlist
    res.sendFile(path.resolve('portal/playlists/numeracy/' + selected_course + '/' + selected_playlist + '.html'));
});

module.exports = router