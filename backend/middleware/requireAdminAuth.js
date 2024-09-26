
const jwt = require('jsonwebtoken');
const { adminModel } = require('../models/mainModel');


const requireAdminAuth = async ( req, res, next )=>{
 
    //verify authentication
    const { authorization } = req.headers;

    if (!authorization) {
        return res.status(401).json({error: 'Admin Authorization token required'});
    }
 
    const token = authorization.split(' ')[1];

    try  {

        const { _id } = jwt.verify(token, process.env.SECRET);
        req.user = await adminModel.findOne({_id}).select('_id');
        next();

    } catch (error) { 
        console.log(error);
        res.status(401).json({error: 'Request is not authorized'});
    }
 
}

module.exports = requireAdminAuth; 