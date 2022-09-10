const mongoose = require('mongoose')
const Schema = mongoose.Schema

const newSchema = new Schema({
    mail:String,
    password:String
})

module.exports = mongoose.model('User',newSchema)