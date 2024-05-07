const express = require('express');
const jwt = require('jsonwebtoken');
const parse = require('body-parser');
const auth = require('../domain/authentication.js');
const tkn = require('../domain/token-management.js');
require('dotenv').config();

const app = express();
const port = 4000;


app.use(parse.urlencoded({ extended: true }));
app.use(parse.json());

app.post('/validatetoken', async (req, res) => {
    let q = await tkn.isTokenIntact(req.headers['token']);
    res.status(200).send({status: q});
});

app.post('/deneme', async (req, res) => {
    const [username, mail] = ['hakanus', 'remzi@gmail.com'];
    let q = await auth.checkUserExists(username, mail);
    //console.log(q);
    if(!q.succes)
    {
        res.status(404).send({status: q.succes, error: q.error});
    }
    else {
        res.status(200).send({status: q.succes, count: q.result['count']});
    }
    
});


app.get('/getsomerandomshit', async (req, res) => {
    const [username, mail] = ['imcomingfromhome baby', 'remzi@gmail.com'];
    res.status(200).send({username: username, mail: mail});
    
});



app.post('/token', async (req, res) => {
    let q = {};
    const [username, mail] = ['hakanus', 'remzi@gmail.com'];
    q = await auth.checkUserExists(username, mail);
    if(!q.status)
    {
        res.status(401).send({status: q.succes, error: q.error});
        return;
    }
    else {
        q = await tkn.generateAccessToken(username);
        if(!q.status) {
            res.status(403).send({status: q.status, error: q.error});
        }
        else {
            res.status(200).send({status: q.succes, token: q.result['token']});
        }
    }
    
});


app.post('/verify', async (req, res) => {
    let q = {};
    const token = req.headers['token'];
    q = await tkn.verifyToken(token);
    if(!q.status) {
        res.status(400).send({status: q.status, error: q.error});
    }
    else {
        res.status(201).send({status: q.status, verify: q.result, error: q.error});
    }
    
    
});


app.post('/request', async (req, res) => {
    const ipAddress = req.headers['x-forwarded-for']?.split(',').shift()
    || req.socket?.remoteAddress;

    const userAgent = req.headers['user-agent'] ? req.headers['user-agent'] : '';
    //let q = {};
    //const token = req.headers['token'];
    //q = await tkn.verifyToken(token);
    //if(!q.status) {
    //    res.status(400).send({status: q.status, error: q.error});
    //}
    //else {
    //    res.status(201).send({status: q.status, verify: q.result, error: q.error});
    //}
    const location = await auth.location('94.121.173.9');
    res.send({ip: ipAddress, device: userAgent, country: location.country, city: location.city});
});


app.post('/api/authtoken', async (req, res) => {

    const token = req.body['token'] ? req.body['token'] : '';
    //let q = {};
    //const token = req.headers['token'];
    //q = await tkn.verifyToken(token);
    //if(!q.status) {
    //    res.status(400).send({status: q.status, error: q.error});
    //}
    //else {
    //    res.status(201).send({status: q.status, verify: q.result, error: q.error});
    //}
    if(token == "316231")
        res.status(200).send({status: "succes"});
    else
        res.status(401).send({status: "failure"});
});

app.post('/api/login', async (req, res) => {

    const [username, password] = [req.body["email"], req.body["password"]];
    console.log(username);
    console.log(password);
    if(username === "ali" && password === "1234")
        res.status(200).send({token: "316231"});
    else
        res.status(401).send({error: "invalid username or password"});
    // implement checking inputs

    /*
     * Inputs are:
     * 
     *  identifier (username or mail)
     *  password
     * 
     * Header must include:
     * 
     *  user-agent
     * 
     * Algorithm:
     *  
     *  check if user-agent header exists, if not 401
     *  check if ip address has a valid country and city, if not 401
     *  sanitize identifier and password 
     *  check if user exists, if not 401
     *  
     *   
     * 
     * 
    */
});


app.post('/register', async (req, res) => {

    // implememtn checking if inputs valid
    /*
     * Inputs are: 
     * 
     *  username,
     *  mail address,
     *  password
     * 
     * Header must include:
     * 
     *  user-agent
     * 
     * 
     * Algorithm:
     *  
     *  check if user-agent header exists, if not 401
     *  check if ip address has a valid country and city, if not 401
     *  sanitize username, mail adress and password
     *  check if username already used, if used 401
     *  check if mail address already used, if used 401
     *  
     *  all check, user can register now!
     * 
     *  hash the password,
     *  generate access token using username with expiration of 15 min
     *  generate refresh token using username + device model with no expiration
     * 
     * Insert into database:
     * 
     *  username:
     *  mail:
     *  password:
     *  devices: [{device:, refreshtoken:}]
     * 
    */
    const ipAddress = req.headers['x-forwarded-for']?.split(',').shift()
    || req.socket?.remoteAddress;

    const userAgent = req.headers['user-agent'] ? req.headers['user-agent'] : '';
    //let q = {};
    //const token = req.headers['token'];
    //q = await tkn.verifyToken(token);
    //if(!q.status) {
    //    res.status(400).send({status: q.status, error: q.error});
    //}
    //else {
    //    res.status(201).send({status: q.status, verify: q.result, error: q.error});
    //}
    const location = await auth.location('94.121.173.9');
    res.send({ip: ipAddress, device: userAgent, country: location.country, city: location.city});
});




















//app.post('/login', async (req, res, next) => { 
//    const {identifier, password} = await req.body;
//    // check if identifier, password and name send by request
//    if(!identifier || !password)
//    {
//        return res.status(400).send({message: "Mail or password missing!"});
//    }
//
//    const user = users.find(user => user.username == identifier);
//
//    if(!user)
//        return res.status(400).send('Can not find user!');
//
//    try
//    {
//        if(await bcrypt.compare(password, user.password))
//        {
//        const [a, b, token] = await tkn.CreateToken(user);
//        const [return_code, message, validation_rsa, validation_jwt] = await tkn.VerifyToken(token);
//        res.json({token : token, is_token_rsa_valid: validation_rsa, is_token_jwt_valid: validation_jwt});
//            
//        }
//        else
//        {
//            res.status(400).send('Password is not matching.');
//        }
//    }
//    catch(error)
//    {
//        return res.status(500).send('Service not working.' +  error.message);
//    }
//
//})
//
//
//app.post('/register', async (req, res) => {
//    const {username, mail, password} = req.body;
//
//    // check if email, password and name send by request
//    if(!username || !mail || !password)
//    {
//        return res.status(400).send({message: "Mail or password missing!"});
//    }
//
//    // check if email is valid
//
//    // check database if user already exists
//
//    try
//    {
//        const hashed_password = await bcrypt.hash(req.body.password, 10);
//        console.log(hashed_password);     
//        res.status(200).send({username: username, mail: mail, password:hashed_password});
//    }
//    catch
//    {
//        res.status(500).send();
//    }
//
//    return res.status(201).send();
//
//    
//})
//
//app.post('/users', async (req, res) => {
//    try
//    {
//        const hashed_password = await bcrypt.hash(req.body.password, 10);
//        console.log(req.body.username);
//        console.log(hashed_password);     
//        res.status(200).send();
//    }
//    catch
//    {
//        res.status(500).send();
//    }
//})
//


