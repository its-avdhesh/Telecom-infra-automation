const bcrypt = require('bcrypt')
const userModel = require('../models/user.model')

const registerController = async(req,res) =>{
    try {
        const {userName, email, password} = req.body
        if (!userName || !email || !password){
            return res.status(400).json({message:"All fields are required"})
        }
        const saltRound = 10
        const hashPassword = await bcrypt.hash(password,10)

        const user = await userModel.create({
            userName,
            email,
            password:hashPassword
        })
        return res.status(201).json({
            message: "new user has been create successfully",
            user: {
                userName: user.userName,
                email: user.email,
            }
        })
        
    } catch (error) {
        return res.status(500).json({message:error.message})
        
    }
}

module.exports = registerController




