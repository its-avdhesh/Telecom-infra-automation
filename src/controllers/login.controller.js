const jwt = require("jsonwebtoken")
const bcrypt = require("bcrypt")
const userModel = require("../models/user.model")

const userLogin = async (req,res) =>{
    try {
        const {email, password} = req.body
        if (!email || !password){
            return res.status(400).json({message:"All fields are required"})
        }
        const user = await userModel.findOne({email})
        if (!user){
            return res.status(404).json({message:"User not found"})
        }
        const isPasswordCorrect = await bcrypt.compare(password,user.password)
        if(!isPasswordCorrect){
            return res.status(401).json({message:"Invalid credentials"})
        }
        const token = await jwt.sign({id: user._id},process.env.JWT_SECRET,{expiresIn:"10h"})
        res.cookie("token", token)
        return res.status(200).json({message:"Login successful", user:{
            userName: user.userName,
            email: user.email,
        }})
        
    } catch (error) {
        return res.status(500).json({message:error.message})
    }
}

module.exports = {
    userLogin
}