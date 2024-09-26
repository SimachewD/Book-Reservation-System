const mongoose = require('mongoose');

// Define schema for books
const bookSchema = new mongoose.Schema({
    id: {
        type: String,
    }, 
    title: {
        type: String,
        required: true
    }, 
    author: { 
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'Author', 
        required: true 
    },  
    publicationDate: {
        type: Date,
        required: true
    }, 
    coverImage: {
        type: String,// img url
        required: true
    }, 
    status: { 
        type: String, 
        enum: ['new release', 'normal', 'popular'], 
        default: 'new release' 
    },
    isAvailable: Boolean 
  } 
  );


// Define schema for users
const userSchema = new mongoose.Schema({
    id: String,
    phone: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true
    },
    password: {
        type: String,
        required: true
    },
});  


// Define schema for admin
const adminSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true
    },
    password: {
        type: String,
        required: true
    },
});  

// Define schema for UserBooks
const userBooksSchema = new mongoose.Schema({
    user: { 
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'User', 
        required: true 
    },
    book: { 
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'Book', 
        required: true 
    },
    status: { 
        type: String, 
        enum: ['favorite', 'reserved', 'pending', 'purchased'], 
        required: true 
    },
    reservedDate: { 
        type: Date, 
        default: Date.now 
    },
    dueDate: { 
        type: Date,  
        required: true   
    }
  }); 

  const authorSchema = new mongoose.Schema({
    name: { 
        type: String, 
        required: true 
    },
    books:[{ 
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'Book', 
        required: true 
    }],
    popularityScore: { 
        type: Number, 
        required: true 
    }
  });


// Create models based on schemas
const bookModel = mongoose.models.Book || mongoose.model('Book', bookSchema);
const userModel = mongoose.models.User || mongoose.model('User', userSchema);
const adminModel = mongoose.models.Admin || mongoose.model('Admin', adminSchema);
const userBooksModel = mongoose.models.UserBook || mongoose.model('UserBook', userBooksSchema);
const authorModel = mongoose.models.Author || mongoose.model('Author', authorSchema);
 
module.exports = { bookModel, userModel, adminModel, userBooksModel, authorModel };
