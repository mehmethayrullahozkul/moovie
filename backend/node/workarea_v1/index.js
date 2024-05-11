const express = require('express');
const parse = require('body-parser');
const base64url = require('base64url');
const tokenManagement = require('./token_management.js');
const jwt = require('jsonwebtoken');
const userService = require('./user_service.js');
const wordPair = require('./word_pair_generator.js');



const app = express();
const port = 3040;






app.use(parse.urlencoded({ extended: true }));
app.use(parse.json());



app.listen(port, async () => 
    {
        await wordPair.load();
        console.log(`Server is running on port ${port}`);
    }
);


app.use((err, req, res, next) => {
    if (err instanceof SyntaxError && err.status === 400 && 'body' in err) {
        console.error(err);
        return res.status(400).send({ status: 400, message: err.message }); // Bad request
    }
    next();
});


app.get('/', (req, res) => {
    res.status(200).send({status: true, message: 'Server is running.'});
});

app.get('/banana', async (req, res) => {
    res.status(200).send({status: true, message: 'Banana is eaten alive.'});
});

app.get('/getrandomwordpairs', async (req, res) => {

    const count = req.body['count'];

    if(count == undefined || count == null || count == '')
    {
        res.status(400).send({status: false, error: 'count is not defined'});
        return;
    }

    if(typeof count !== 'string' && typeof count !== 'number')
    {
        res.status(400).send({status: false, error: 'count is not a string or number'});
        return;
    }



    if(typeof count === 'string')
    {
        let parse = count.match(/^\d+$/g);
        if(parse == null)
        {
            res.status(400).send({status: false, error: 'count is not a number'});
            return;
        }
    }

    
   
    let wordCount = parseInt(count);

    if(isNaN(wordCount))
    {
        res.status(400).send({status: false, error: 'count is not a number'});
        return;
    }

    if(wordCount < 1)
    {
        res.status(400).send({status: false, error: 'count is less than 1'});
        return;
    }

    if(wordCount > 100)
    {
        wordCount = 100;
    }

    let wordPairs = wordPair.getRandomWordPairs(wordCount);



    res.status(200).send({status: true, wordPairs: wordPairs});
    
});

app.post('/api/login', async (req, res) => {
    const {username, password} = req.body;

    if(!username || !password)
    {
        res.status(400).send({status: false, error: 'Username or password is missing.'});
        return;
    }

    if(!userService.hasUser(username, password))
    {
        res.status(400).send({status: false, error: 'No user found.'});
        return;
    }

    if(!userService.authenticateUser(username, password))
    {
        res.status(400).send({status: false, error: 'Username or password is wrong.'});
        return;
    }


    const token = await tokenManagement.generateAccessToken(username);

    if(!token.status)
    {
        res.status(500).send({status: false, error: 'Service not working.' + token.error});
        return;
    }
    else
    {
        res.status(200).send({status: true, accessToken: token.result['token'], username: username, mail: userService.getUserByUsername(username).mail});
    }
});


app.get('/api/secret-data', async (req, res) => {
    let q = {};
    const username = req.body['username'];
    const token = req.body['token'];


    if(!token || token == undefined || token == null || typeof token !== 'string' || token == '')
    {
        res.status(400).send({status: false, error: 'Token is missing.'});
        return;
    }

    if(!username || username == undefined || username == null || typeof username !== 'string' || username == '')
    {
        res.status(400).send({status: false, error: 'Username is missing.'});
        return;
    }

    const [h, p, s] = token.split('.');
    const decodedPayload = JSON.parse(base64url.decode(p));
    const tokenUsername = decodedPayload.username;

    if(tokenUsername !== username)
    {
        res.status(400).send({status: false, error: 'Username is not matching with token.'});
        return;
    }

    q = await tokenManagement.verifyToken(token);
    if(!q.status) {
        res.status(400).send({status: q.status, error: q.error});
    }
    else {
        // Token is verified
        const user = userService.getUserByUsername(username);
        res.status(200).send({status: true, data: {'secret-data': user.secretData}});
    }
    
    
});


app.post('/getrandomwordpairs', async (req, res) => {

    const count = req.body['count'];

    if(count == undefined || count == null || count == '')
    {
        res.status(400).send({status: false, error: 'count is not defined'});
        return;
    }

    if(typeof count !== 'string' && typeof count !== 'number')
    {
        res.status(400).send({status: false, error: 'count is not a string or number'});
        return;
    }



    if(typeof count === 'string')
    {
        let parse = count.match(/^\d+$/g);
        if(parse == null)
        {
            res.status(400).send({status: false, error: 'count is not a number'});
            return;
        }
    }

    
   
    let wordCount = parseInt(count);

    if(isNaN(wordCount))
    {
        res.status(400).send({status: false, error: 'count is not a number'});
        return;
    }

    if(wordCount < 1)
    {
        res.status(400).send({status: false, error: 'count is less than 1'});
        return;
    }

    if(wordCount > 100)
    {
        wordCount = 100;
    }

    let wordPairs = wordPair.getRandomWordPairs(wordCount);



    res.status(200).send({status: true, wordPairs: wordPairs});
    
});

