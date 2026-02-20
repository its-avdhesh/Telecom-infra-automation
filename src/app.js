const express = require("express")
const app = express()
const cookieParser = require("cookie-parser")
const path = require("path")

const userRoutes = require("./routes/user.routes")
const authMiddleware = require("./middleware/auth.middleware")

app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, 'views'))
app.use(express.static(path.join(__dirname, '../public')))

app.use(express.json())
app.use(cookieParser())

app.use("/api",userRoutes)

app.get('/', (req, res) => {
    res.render('homepage')
})

app.get('/login', (req, res) => {
    res.render('login')
})

app.get('/register', (req, res) => {
    res.render('register')
})

app.get('/services', authMiddleware, (req, res) => {
    res.render('services')
})

app.get('/development', (req, res) => {
    res.render('development')
})

module.exports = app