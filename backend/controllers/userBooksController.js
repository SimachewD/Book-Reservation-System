

const {userBooksModel} = require('../models/mainModel');

// Create a new reservation
exports.createUserBook = async (req, res) => {
  try {
    const { userId, bookId, status, dueDate } = req.body;
    const newUserBook = new userBooksModel({user:userId, book:bookId, status:status, dueDate:dueDate});
    await newUserBook.save();
    res.status(201).json(newUserBook);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Get all books for a user
exports.getUserBooks = async (req, res) => {
  try {
    const userBooks = await userBooksModel.find({ user: req.params.userId }).populate('book');
    res.status(200).json(userBooks);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Get user book detail by id
exports.getUserBookDetail = async (req, res) => {
  try {
    const userBookDetail = await UserBooks.find({ user: req.params.userId, book: req.params.bookId }).populate('book').populate('user');
    res.status(200).json(userBookDetail);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Add or update a book status for a user
exports.updateUserBookStatus = async (req, res) => {
  try {
    const { userId, bookId, status } = req.body;
    const userBook = await userBooksModel.findOneAndUpdate(
      { userId, bookId },
      { status },
      { new: true, upsert: true, runValidators: true }
    );
    res.status(200).json(userBook);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Delete a book by ID for a user
exports.deleteUserBook = async (req, res) => {
  try {
    const book = await userBooksModel.findByIdAndDelete(req.params.id);
    if (!book) {
      return res.status(404).json({ error: 'Book not found' });
    }
    res.status(200).json({ message: 'User book deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: error.message});
  }
};
