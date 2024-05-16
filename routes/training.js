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

router.get('/:training', (req, res) => {
    let selected_module = "coach_training"
    let selected_training = req.params.training
    res.sendFile(path.resolve(
        path.join(selected_module, selected_training + '.html')
    ))
});

module.exports = router