const express = require('express');

const router = express.Router();

const path = require('path');



/* Use the public directory to serve static assets */

router.use(express.static(path.resolve(

    path.join(__basedir, 'public')

)));



/* Handle root path to serve index.html */
router.get('/', (req, res) => {
    const indexPath = path.resolve(
        path.join(__basedir, 'skills_hub', 'index.html')
    );

    if (!require('fs').existsSync(indexPath)) {
        return res.status(404).send('Skills Hub index not found');
    }

    res.sendFile(indexPath);
});

/* Get the selected test as a param of the request */
/* then construct the path to the html file */
/* It is assumed that the name of the html file is the same as the requested test */
router.get('/:quiz', (req, res) => {
    let selected_module = "skills_hub";
    let selected_test = req.params.quiz + '.html';

    /* Construct path to the selected test in the skills_hub directory */
    const filePath = path.resolve(
        path.join(__basedir, selected_module, selected_test)
    );

    // Check if file exists before sending
    if (!require('fs').existsSync(filePath)) {
        return res.status(404).send('Assessment not found');
    }

    res.sendFile(filePath);
});

module.exports = router;