
const {bookModel, authorModel, userBooksModel} = require('../models/mainModel');

// add a new book
exports.addBook = async (req, res) => {
 
    const fileName = req.file.filename ;
    const { title, authorName, popularityScore, publicationDate } = req.body;

    // Find or create the author
    let author = await authorModel.findOne({ name: authorName });
    if (!author) {
      author =  new authorModel({ name: authorName, popularityScore: popularityScore });
      await author.save();
    }

   bookModel.create({title, author:author._id, publicationDate, coverImage:fileName}).then(async (book)=>{
        // Add the book to the author's list of books and save the author
        author.books.push(book._id);
        await author.save();
        res.status(200).json(book);
    }).catch(error=>{
        res.status(404).json({error:error.message});
    });
};

// Get all books
exports.getAllBooks = async (req, res) => {
  try { 
    const books = await bookModel.find().populate('author');
    res.status(200).json(books); 
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
}; 
 
// Get a book by ID    
exports.getBookDetail = async (req, res) => {
  try {
    const book = await bookModel.findById(req.params.id).populate('author');
    if (!book) {
      return res.status(404).json({ error: 'Book not found' });
    }
    res.status(200).json(book);
  } catch (error) {
    res.status(400).json({ error: error.message }); 
  }
};

// Get all books for a user
exports.getUserBooks = async (req, res) => {
  try {
    const userBooks = await userBooksModel.find().populate('book');
    res.status(200).json(userBooks);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};
  
//Update a book by ID
exports.updateBookStatus = async (req, res) => {
  try {
    const book = await Book.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
    if (!book) {
      return res.status(404).json({ error: 'Book not found' });
    }
    res.status(200).json(book);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
}; 

// Delete a book by ID
exports.deleteBook = async (req, res) => {
  try {
    const book = await bookModel.findByIdAndDelete(req.params.id);
    if (!book) {
      return res.status(404).json({ error: 'Book not found' });
    }
    res.status(200).json({ message: 'Book deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};
