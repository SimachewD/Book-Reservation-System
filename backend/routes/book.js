


const { getBookDetail, getAllBooks } = require('../controllers/bookController');
const { getUserBooks, updateUserBookStatus, createUserBook, deleteUserBook, getUserBookDetail } = require('../controllers/userBooksController');
const requireUserAuth = require('../middleware/requireUserAuth');


const express = require('express');

const router = express.Router(); 

router.get('/books', getAllBooks); 

router.get('/books/bookdetails/:id', getBookDetail)


router.post( '/books/reservebook', requireUserAuth, createUserBook);

router.get( '/books/reservedbooks', requireUserAuth, getUserBooks);

router.get( '/books/getuserbook/:id', requireUserAuth, getUserBookDetail);
 
router.delete('/books/deleteuserbook/:id', requireUserAuth, deleteUserBook);

router.patch( '/books/updateuserbook/:id', requireUserAuth, updateUserBookStatus);


module.exports = router;
