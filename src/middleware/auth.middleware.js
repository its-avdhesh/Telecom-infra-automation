const jwt = require('jsonwebtoken')

const authMiddleware = async(req,res,next) =>{
    try {
        const token = req.cookies.token
        if(!token){
            return res.redirect('/login')
        }
        const decode = await jwt.verify(token,process.env.JWT_SECRET)
        req.user = decode
        next()

        
    } catch (error) {
        res.clearCookie('token')
        return res.redirect('/login')
    }
}

module.exports = authMiddleware