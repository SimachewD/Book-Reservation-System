
const bcrypt = require('bcrypt');
const validator = require('validator');
const jwt = require('jsonwebtoken');


const {userModel} = require('../models/mainModel');

// Create a new user
const createUser = async (req, res) => {
    const { phone, email, password } = req.body;

    if (!validator.isEmail(email)) {
      return res.status(400).json({Error:'Invalid Email'});
    }

    const user = await userModel.findOne({email});
    if(user){
      return res.status(404).json({Error:'Email already in-use'});
    }

    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(password, salt);
try {
  const response = await userModel.create({ phone, email, password: hash });
  if (response) {
    const token = jwt.sign({user:response._id}, process.env.SECRET, {expiresIn:'3d'});
    res.status(200).json({_id:response._id, email, token});
    // res.status(200).json({message:'Registeration successful'});
  }
} catch (err) {
  return res.status(404).json({Error: err.message});
}   
};
  

//login 
const Login = async (req, res)=>{

    const { email, password } = req.body; 

    if (!email || !password) {
      return res.status(404).json({Error:'All Fields Must be Filled'});
    }

    if (!validator.isEmail(email)) {
      return res.status(400).json({Error:'Invalid Email'});
    }

    userModel.findOne({email}).then(async (user)=>{
          const match = await bcrypt.compare(password, user.password);
          if (!match) {
            return res.status(404).json({Error:'Wrong Password'});
            // throw Error('Wrong password');
          }
          const token = jwt.sign({ user: user._id }, process.env.SECRET, { expiresIn: '3d' });
          res.status(200).json({_id:user._id, email, token});
    }).catch(()=>{
      res.status(400).json({Error:'User Not Found'});
      // throw Error('User not found');
    });
}



// Get all users
const getAllUsers = async (req, res) => {
  try {
    const users = await userModel.find();
    res.status(200).json(users);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Delete a user
const deleteUser = async (req, res) => {
  try {
    const user = await userModel.findByIdAndDelete(req.params.id);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.status(200).json({ message: 'User deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};


module.exports = { createUser, deleteUser, getAllUsers, Login };