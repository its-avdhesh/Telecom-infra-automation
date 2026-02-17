require('dotenv').config()
const app = require('./src/app')
const connectDB = require('./src/config/db')




const server = async() =>{
    try {
        await connectDB()
        await app.listen(process.env.PORT)
        console.log(`Server is running on port ${process.env.PORT}`)
    } catch (error) {
        console.log("Server Error",error.message)
    }

}

server()