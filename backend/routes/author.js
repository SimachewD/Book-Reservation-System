

const { getAuthors } = require('../controllers/authorController');

const express = require('express');

const router = express.Router(); 

router.get('/authors', getAuthors);


module.exports = router;
