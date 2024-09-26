
const userBooksModel = require('../models/mainModel');

// Create a new reservation
exports.createReservation = async (req, res) => {
  try {
    const { userId, bookId, status, dueDate } = await req.body;
    const newUserBook = new userBooksModel({user:userId, book:bookId, status:status, dueDate:dueDate});
    await newUserBook.save();
    res.status(201).json(reservation);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// get reserved books for a user
exports.getReservedBooks = async (req, res) => {
  try {
    const books = await userBooksModel.find({ user:req.params.userId, status:'reserved' }).populate('book').exec();
    res.status(200).json(books);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch your reservations' });
  }
};

// Get pending books for a user
exports.getPendingBooks = async (req, res) => {
  try {
    const books = await userBooksModel.find({ user: req.params.userId, status:'pending' }).populate('book');
    res.status(200).json(books);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch your pending requests' });
  }
};

// Get purchased books for a user
exports.getPurchasedBooks = async (req, res) => {
  try {
    const books = await userBooksModel.find({user: req.params.id, status:'purchased'}).populate('book');
    res.status(200).json(books);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch your purchases' });
  }
};

// Get favorite books for a user
exports.getFavoriteBooks = async (req, res) => {
  try {
    const books = await userBooksModel.find({user:req.params.id, status:'favorite'}).populate('book');
    res.status(200).json(books);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch your favorites' });
  }
};

// Delete a reservation by ID
exports.deleteReservation = async (req, res) => {
  try {
    const reservation = await userBooksModel.findByIdAndDelete(req.params.id);
    if (!reservation) {
      return res.status(404).json({ error: 'Reservation not found' });
    }
    res.status(200).json({ message: 'Reservation deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Unable to delete'});
  }
};
