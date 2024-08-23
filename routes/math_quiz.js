const express = require('express');
const router = express.Router();
const path = require('path');

/* Use the public directory to serve static assets */
router.use(express.static(path.resolve(
    path.join(__basedir, 'public')
)));

/* Get the selected test as a param of the request */
/* then construct the path to the html file */
/* It is assumed that the name of the html file is the same as the requested test */
router.get('/:test', (req, res) => {
    let selected_module = "math_quiz";
    let selected_test = req.params.test;
    
    /* Construct path to the selected test in the math_quiz directory */
    res.sendFile(path.resolve(
        path.join(selected_module, selected_test + '.html')
    ));
});

module.exports = router;
