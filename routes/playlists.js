const express = require('express')
const router = express.Router()
const path = require('path')

/*Use the public directory to serve static assets*/
router.use(express.static(path.resolve(
                path.join(__basedir, 'public')
            )))
/*Get the selected test as a param of the request*/
/*then construct the path to the html file*/
/*It is assumed that the name of the html file is the same as the requested test*/
router.get('/:module/:course/:playlist', (req, res) => {
    let selected_module = req.params.module
    let selected_course = req.params.course
    let selected_playlist = req.params.playlist
    res.sendFile(path.resolve(
    	path.join('portal/playlists', selected_module,selected_course, selected_playlist + '.html')
    	))
})

module.exports = router