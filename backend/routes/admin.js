

const multer = require('multer');

const express = require('express')
const requireAdminAuth = require('../middleware/requireAdminAuth');

const {
        createAdmin,
        login,
        updateProfile,
        changePassword } = require('../controllers/adminController');
const {
        addBook,
        deleteBook, 
        updateBookStatus,
        getUserBooks} = require('../controllers/bookController');

const {
        deleteUser,
        getAllUsers } = require('../controllers/userController');
const { updateUserBookStatus } = require('../controllers/userBooksController');



// Define storage for uploaded files
const storage = multer.diskStorage({
        destination: function (req, file, cb) {
          cb(null, 'uploads/') // Directory where uploaded files will be stored
        },
        filename: function (req, file, cb) {
          // Generate a unique filename for the uploaded file
          cb(null, Date.now() + '-' + file.originalname)
        }
      })
      
      const upload = multer({ storage: storage });



const router = express.Router();

router.post('/createadmin', createAdmin)

router.post( '/admin/login', login);

router.patch( '/admin/changepassword', requireAdminAuth, changePassword);

router.patch( '/admin/updateprofile', requireAdminAuth, updateProfile);

 
router.post( '/admin/addbook', requireAdminAuth, upload.single('coverImage'), addBook);

router.get( '/admin/userbooks', requireAdminAuth, getUserBooks);

router.post( '/admin/updateuserbookstatus', requireAdminAuth, updateUserBookStatus);

router.post( '/admin/updatbookstatus', requireAdminAuth, updateBookStatus);

router.delete( '/admin/deletebook/:id', requireAdminAuth, deleteBook); 

router.get( '/admin/users', requireAdminAuth, getAllUsers);
 
router.delete('/admin/deleteusers/:id', requireAdminAuth, deleteUser);



module.exports = router;
 