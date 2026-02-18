const mongoose = require("mongoose")

const userSchema = new mongoose.Schema({
    
    userName: {
        required: true,
        type: String,
        unique:true

    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
})


module.exports = mongoose.model("userModel", userSchema)