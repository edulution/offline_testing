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
router.get('/:test', (req, res) => {
    let selected_module = "literacy"
    let selected_test = req.params.test
    /* Construct path to Grade 7 revision numeracy */
    res.sendFile(path.resolve(
        path.join(selected_module, selected_test + '.html')
    ))
});

module.exports = router