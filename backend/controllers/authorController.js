const { authorModel } = require("../models/mainModel");

// // Add a new popular author
// exports.addAuthor = async (req, res) => {
//   try {
//     const author = new authorModel(req.body);
//     await author.save();
//     res.status(201).json(author);
//   } catch (error) {
//     res.status(400).json({ error: error.message });
//   }
// };

// Get all popular authors
exports.getAuthors = async (req, res) => {
  try {
    const authors = await authorModel.find().populate('books');
    res.status(200).json(authors);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};
