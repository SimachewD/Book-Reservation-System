
const jwt = require('jsonwebtoken');
const { userModel } = require('../models/mainModel');


const requireUserAuth = async ( req, res, next )=>{
 
    //verify authentication
    const { authorization } = req.headers;

    if (!authorization) {
        return res.status(401).json({error: 'User Authorization token required'});
    }
 
    const token = authorization.split(' ')[1];

    try  {

        const { user } = jwt.verify(token, process.env.SECRET);
        req.user = await userModel.findById({_id:user}).select('_id');
        next();
    } catch (error) { 
        console.log(error);
        res.status(401).json({error: 'Request is not authorized'});
    }
 
}
 
module.exports = requireUserAuth; 