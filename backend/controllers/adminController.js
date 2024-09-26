
const bcrypt = require('bcrypt');
const validator = require('validator');
const jwt = require('jsonwebtoken');

const { adminModel } = require("../models/mainModel");


//create admin
const createAdmin = async (req, res)=>{
 
  const { email, password } = req.body;
    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(password, salt);
    adminModel.create({ email, password: hash }).then(() => {
        res.status(200).json({Success:'Admin created successfully'});
      }).catch((err)=> {
        return res.status(404).json({'Error creating admin:': err});
      });
}

//Admin login
const login = async (req, res)=>{

    const { email, password } = req.body;
console.log(req.body);
    if (!email || !password) {
      return res.status(404).json({Error:'All Fields Must be Filled'});
      // throw Error('All fields must be field');
    }

    if (!validator.isEmail(email)) {
      return res.status(400).json({Error:'Invalid Email'});
      // throw Error('Invalid Email');
    }

    adminModel.findOne({email}).then(async (admin)=>{
          const match = await bcrypt.compare(password, admin.password);
          if (!match) {
            return res.status(404).json({Error:'Wrong Password'});
            // throw Error('Wrong password'); 
          }
          const token = jwt.sign({admin:admin._id}, process.env.SECRET, {expiresIn:'3d'});
          res.status(200).json({email, token});
    }).catch(()=>{
      res.status(400).json({Error:'User Not Found'});
      // throw Error('User not found');
    });
}

 

//edit admin data
const changePassword = async (req, res)=>{

  const { email, oldPassword, newPassword } = req.body;
    const admin = await adminModel.findOne({email});
    if (!admin) {
      return res.status(400).json({Error:'User Not Found'});
    }

    const match = await bcrypt.compare(oldPassword, admin.password);

    if (!match) {
      return res.status(400).json({Error:'Wrong Password'});
    }
    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(newPassword, salt);
    adminModel.findOneAndUpdate( {}, { password:hash }, { new: true }).then(() => {
        res.status(200).json({Success:'Password Changed Successfully'});
      }).catch((err)=> {
        return res.status(404).json({'Error updating password:': err});
      });
} 
 
 
//edit profile
const updateProfile = (req, res)=>{

    profileModel.findOneAndUpdate( {}, { ...req.body }, { new: true }).then(() => {
        res.status(200).json({success:'profile updated successfully for admin'});
      }).catch((err)=> {
        return res.status(404).json({'Error updating profile:': err});
    });
}


module.exports = {
    changePassword,
    updateProfile,  
    login,
    createAdmin
}; 