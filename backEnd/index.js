const express = require('express')
const app = express()
const port = 8080 || process.env.PORT
const cors = require('cors')
const bodyParser = require('body-parser')

const mongoose = require('mongoose')
const { use } = require('./routes/user.route')
mongoose.connect('mongodb://127.0.0.1:27017/mydb',{ useNewUrlParser: true, 
useUnifiedTopology: true }).then(() => {
    
console.log("Connected to Database");
}).catch((err) => {
    console.log("Not Connected to Database ERROR! ", err);
});


app.use(cors())
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())
app.use('/',require('./routes/user.route'))
app.listen(port,()=>{
    console.log('port running on '+port)
})