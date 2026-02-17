const express = require('express')
const router = express.Router()



const registerController = require('../controllers/register.controller')
const userLoginController = require('../controllers/login.controller')





router.post('/register', registerController)
router.post('/login', userLoginController.userLogin)

module.exports = router