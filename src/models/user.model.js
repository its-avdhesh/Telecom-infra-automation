const mongoose = require("mongoose")

const userSchema = new mongoose.Schema({
    userName: {
        require: true,
        type: String,
        unique:true

    },
    email: {
        type: String,
        require: true,
        unique: true
    },
    password: {
        type: String,
        require: true
    },
})


module.exports = mongoose.model("userModel", userSchema)