const express = require('express')
const mongoose = require('mongoose')
const bodyParser = require('body-parser');
const path = require('path');
const cors = require('cors');

require('dotenv').config();

const app = express();


// const allowedOrigins = ['http://localhost:3000','http://localhost:12319/', 'http://localhost:12319/', 'http://localhost:5173', 'http://192.168.0.146:3000'];

app.use(cors());

app.use('/my_library/api/uploads', express.static(path.join(__dirname, 'uploads')));


mongoose.connect(process.env.MONGO_URI).then((conn)=>{

    console.log('Connected to DB: ' + conn.connection.host);
    app.listen(process.env.PORT, ()=>{ 
        console.log(`Server running on: ${process.env.PORT}`);
    })
}).catch((error)=>{
    console.log('Connection Failed: ' + error);
});

  
//middleware to parse the request body  
app.use(express.json());  

// Middleware to parse form-data
app.use(express.urlencoded({extended:true}));
  
//handling routes
app.use('/my_library/api/', require('./routes/admin'))      
app.use('/my_library/api/', require('./routes/user'))
app.use('/my_library/api/', require('./routes/book'))      
app.use('/my_library/api/', require('./routes/author'))      

