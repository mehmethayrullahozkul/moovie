const express = require('express');
const parse = require('body-parser');
const base64url = require('base64url');
const tokenManagement = require('./token_management.js');
const jwt = require('jsonwebtoken');
const userRepository = require('./user_service.js');
const strutl = require('./string_utilities.js');
const wordPair = require('./word_pair_generator.js');
/* const userRepository = require('./db.js'); */




const app = express();
const port = 3040;






app.use(parse.urlencoded({ extended: true }));
app.use(parse.json());

app.use(accessTokenValidation);


async function accessTokenValidation(req, res, next) {

    if(req.path == '/api/login' || req.path == '/getsomerandomwordpairs')
    {
        next();
        return;
    }


    let q = {};
    const token = req.headers['authorization'];


    if(!token || token == undefined || token == null || typeof token !== 'string' || token == '')
    {
        res.status(400).send({status: false, error: 'Token is missing.'});
        return;
        
    }

    q = await tokenManagement.verifyToken(token);

    if(!q.status) {
        res.status(400).send({status: false, error: 'Token is not valid.'});
        return;
    }
    else {
        next();
    }
}

function parseAccessTokenUsername(token)
{
    const [h, p, s] = token.split('.');
    const decodedPayload = JSON.parse(base64url.decode(p));
    if(decodedPayload.username == undefined || decodedPayload.username == null || decodedPayload.username == '')
    {
        return null;
    }
    return decodedPayload.username;
}

function validString(data)
{
    if(!data || data == undefined || data == null || typeof data !== 'string' || data == '')
    {
        return false;
    }
    return true;
}




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



// Server Status
app.get('/api/status', async (req, res) => {
    res.status(200).send({status: true, server: 'running', message: 'Banana is eaten alive.'});
});


app.post('/api/token/refresh', async (req, res) => {
    
        const token = req.headers['authorization'];
    
        const username = parseAccessTokenUsername(token);
    
        if(username == null)
        {
            res.status(400).send({status: false, error: 'Username is missing.'});
            return;
        }
    
        const newToken = await tokenManagement.generateAccessToken(username);
    
        if(!newToken.status)
        {
            res.status(500).send({status: false, error: 'Service not working.' + newToken.error});
            return;
        }
        else
        {
            res.status(200).send({status: true, accessToken: newToken.result['token'], username: username});
        }
});


// Get Random Word Pairs
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



// Login User
app.post('/api/login', async (req, res) => {
    const {username, password} = req.body;

    if(!username || !password)
    {
        res.status(400).send({status: false, error: 'Username or password is missing.'});
        return;
    }

    if(!userRepository.hasUser(username, password))
    {
        res.status(400).send({status: false, error: 'No user found.'});
        return;
    }

    if(!userRepository.authenticateUser(username, password))
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
        res.status(200).send({status: true, accessToken: token.result['token'], username: username, mail: userRepository.getUser(username).mail});
    }
});


// Register User
app.post('/api/users', async (req, res) => {

    const {username, password, mail, secret} = req.body;


    if(!username || !password || !mail || !secret)
    {
        res.status(400).send({status: false, error: 'Username, password, mail or secret data is missing.'});
        return;
    }

    if(typeof username !== 'string' || typeof password !== 'string' || typeof mail !== 'string' || typeof secret !== 'string')
    {
        res.status(400).send({status: false, error: 'Username, password, mail or secret data is not a string.'});
        return;
    }

    if(userRepository.hasUser(username))
    {
        res.status(400).send({status: false, error: 'User already exists.'});
        return;
    }

    userRepository.addUser(username, password, mail, secret, 0, []);


    res.status(200).send({status: true, message: 'User added.'});
});


// Get User
app.get('/api/users/:username', async (req, res) => {
    
    const username = req.params.username;

    if(!username || username == undefined || username == null || typeof username !== 'string' || username == '')
    {
        res.status(400).send({status: false, error: 'Username is missing.'});
        return;
    }

    const tokenUsername = parseAccessTokenUsername(req.headers['authorization']);

    if(tokenUsername !== username)
    {
        res.status(400).send({status: false, error: 'Username is not matching with token.'});
        return;
    }

    const user = userRepository.getUser(username);

    if(user == null)
    {
        res.status(400).send({status: false, error: 'User not found.'});
        return;
    }

    res.status(200).send({status: true, user: user});
});


// Update User Secret
app.post('/api/users/:username/secret', async (req, res) => {


    const username = req.params.username;
    const secret = req.body['secret'];

    if(validString(secret) == false || validString(username) == false)
    {
        res.status(400).send({status: false, error: 'Secret or username is missing.'});
        return;
    }
    var user = userRepository.getUser(username);

    if(user == null)
    {
        res.status(400).send({status: false, error: 'User not found.'});
        return;
    }

    user.secret = secret;

    res.status(200).send({status: true, message: 'Secret data updated.'});

}); 



// Get User Secret
app.get('/api/users/:username/secret', async (req, res) => {

    const username = req.params.username;

    if(validString(username) == false)
    {
        res.status(400).send({status: false, error: 'Username is missing.'});
        return;
    }
    var user = userRepository.getUser(username);

    if(user == null)
    {
        res.status(400).send({status: false, error: 'User not found.'});
        return;
    }


    res.status(200).send({status: true, 'secret': user.secret});

}); 





// Add To Do
app.post('/api/users/:username/todos', async (req, res) => {

    const username = req.params.username;

    if(validString(username) == false)
    {
        res.status(400).send({status: false, error: 'Username is missing.'});
        return;
    }

    const todo = req.body['todo'];


    if(validString(todo) == false)
    {
        res.status(400).send({status: false, error: 'Todo is missing.'});
        return;
    }

    
    const user  = userRepository.getUserAsObject(username);

    const user2 = userRepository.getUser(username);
  

    if(user == null)
    {
        res.status(400).send({status: false, error: 'User not found.'});
        return;
    }

    const todoDate = new Date().toISOString();
    const todoID = strutl.uid(todo + todoDate);
    
    user.addTODOwithID(todoID, todo, todoDate);
    userRepository.updateUser(user);

    const after = userRepository.getUserAsObject(username);
    

    res.status(200).send({status: true, message: 'Todo add success.', 'todo-id': todoID, 'todo': todo, 'date-created': todoDate}); 

});


// Get To Do List
app.get('/api/users/:username/todos', async (req, res) => {

    const username = req.params.username;


    if(validString(username) == false)
    {
        res.status(400).send({status: false, error: 'Username is missing.'});
        return;
    }


    const user  = userRepository.getUserAsObject(username);

    if(user == null)
    {
        res.status(400).send({status: false, error: 'User not found.'});
        return;
    }

    const todoList = user.todoList;
    const todoListCount = user.todoCount;

    res.status(200).send({status: true, 'todo-count': todoListCount, 'todo-list': todoList}); 

});


// Get To Do
app.get('/api/users/:username/todos/:todoID', async (req, res) => {

    const username = req.params.username;
    let q = {};
    if(validString(username) == false)
    {
        res.status(400).send({status: false, error: 'Username is missing.'});
        return;
    }



    const todoID = req.params.todoID;


    if(validString(todoID) == false)
    {
        res.status(400).send({status: false, error: 'To Do is not found.'});
        return;
    }


    var user = userRepository.getUser(username);

    if(user == null)
    {
        res.status(400).send({status: false, error: 'User not found.'});
        return;
    }

    const result = user.todo.list.find(x => x.id === todoID);

    if(result == null)
    {
        res.status(400).send({status: false, error: 'To Do not found.'});
        return;
    }

    console.log(result);
    res.status(200).send({status: true, todo: result.data, 'date-created': result.date, 'todo-id': result.id});

});


// Delete To Do
app.delete('/api/users/:username/todos/:todoID', async (req, res) => {
    
        const username = req.params.username;
        let q = {};
        if(validString(username) == false)
        {
            res.status(400).send({status: false, error: 'Username is missing.'});
            return;
        }


        const todoID = req.params.todoID;

        if(validString(todoID) == false)
        {
            res.status(400).send({status: false, error: 'To Do is missing.'});
            return;
        }


        var user = userRepository.getUser(username);

        if(user == null)
        {
            res.status(400).send({status: false, error: 'User not found.'});
            return;
        }

        const result = user.todo.list.find(x => x.id === todoID);

        if(result == null)
        {
            res.status(400).send({status: false, error: 'To Do not found.'});
            return;
        }

        user.todo.list = user.todo.list.filter(x => x.id !== todoID);

        userRepository.updateUser(user);

        res.status(200).send({status: true, message: 'To Do deleted.', 'todo-id': todoID, 'todo': result.data, 'date-created': result.date});
});

// Update To Do
app.post('/api/users/:username/todos/:todoID', async (req, res) => {
    
    const username = req.params.username;

    if(validString(username) == false)
    {
        res.status(400).send({status: false, error: 'Username is missing.'});
        return;
    }


    const todoID = req.params.todoID;

    if(validString(todoID) == false)
    {
        res.status(400).send({status: false, error: 'To Do is missing.'});
        return;
    }


    var user = userRepository.getUserAsObject(username);

    if(user == null)
    {
        res.status(400).send({status: false, error: 'User not found.'});
        return;
    }

    const result = user.todoList.find(x => x.id === todoID);

    if(result == null)
    {
        res.status(400).send({status: false, error: 'To Do not found.'});
        return;
    }

    const todo = req.body['todo'];

    if(validString(todo) == false)
    {
        res.status(400).send({status: false, error: 'To Do is missing.'});
        return;
    }

    result.data = todo;

    userRepository.updateUser(user);

    console.log("updated user:", user);

    res.status(200).send({status: true, message: 'To Do Updated.', 'todo-id': todoID, 'todo': todo, 'date-created': result.date});
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

