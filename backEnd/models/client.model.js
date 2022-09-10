const mongoose = require('mongoose')

const clients = new mongoose.Schema({
    username : {
        type : String, required : true
    },
    email : {
        type : String , required : true 
    },
    phoneNo : {
        type : String , required : true 
    },
    adresse : {
        type : String
    }
})

module.exports = mongoose.model('clients',clients)