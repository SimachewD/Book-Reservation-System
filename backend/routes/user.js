

const express = require('express')

const { createUser, Login } = require('../controllers/userController');


const router = express.Router();


router.post('/user/createaccount/', createUser);

router.post('/user/login', Login);


module.exports = router;
