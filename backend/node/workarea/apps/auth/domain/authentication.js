const bcrypt = require('bcrypt');
const crypto = require('crypto');
const express = require('express');
const jwt = require('jsonwebtoken');
const parse = require('body-parser');
const tkn = require('./token-management.js');
const conn = require('./connection.js');
var geoip = require('geoip-lite');

require('dotenv').config();

console.log("-- dm/authentication started");

module.exports = {
    checkUserExists: async function(username, mail) {
        try {   
            await conn.connectToMongoDB();

            const db = await conn.getDB('drinkup');
            if(!db) {
                return {status: false, result: null, error: 'cant connect to database'}; 
            }
            const dbUsers = await db.collection('users');
            const dbQuery = {$or: [{username: username}, {mail: mail}]};
            const queryOptions = {
                // sort returned documents in ascending order by title (A->Z)
                sort: { username: 1},
                // Include only the `title` and `imdb` fields in each returned document
                projection: { _id: 0, username: 1, mail: 1},
            };
            //let q = await dbUsers.find(dbQuery, queryOptions).toArray();
            //console.log(Object.keys(q).length);
            let q = {count: await dbUsers.countDocuments(dbQuery)};
            //console.log([{count: 0}]);
            //q.count = Object.keys(q).length;
            //Object.assign(q, {count: Object.keys(q).length});
            console.log(q);
            return {status: true, result: q, error: null}; 
            //if(!Object.keys(q).length) {
            //    q.count = 0;
            //}
            //else {
            //    return {status: true, result: q, error: null}; 
            //}
        }
        catch (e) {
            return {status: false, result: null, error: e.message}; 
        } 
        finally {
            await conn.closeConnection();
        }
    },
    getLocation: async function(ipAddress) {
        const loc = geoip.lookup(ipAddress);
        return {country: loc['country'], city: loc['city']};
    },
    hasToken: function(req, res) {
        if(req.headers.hasOwnProperty('token')) {
            req.HAS_TOKEN = true;
            return true;
        }
        else {
            req.HAS_TOKEN = false;
            return false;
        }
    },
    authState: async function(req, res, next) {
        req.AUTHENTICATED = false;
        if(await module.exports.hasToken(req, res) || req.HAS_TOKEN === true) {
            
        }
    }
};


/*
app.post('/deneme', async (req, res) => {
    try
    {   
        //await client.connect();
        const db = await client.db('drinkup');
        const users = await db.collection('users');
        const query = {username: 'hakanus'};
        const options = {
            // sort returned documents in ascending order by title (A->Z)
            sort: { username: 1},
            // Include only the `title` and `imdb` fields in each returned document
            projection: { _id: 0, username: 1, mail: 1},
        };
        
        //databasesList = await client.db().admin().listDatabases();
 
        //console.log("Databases:");
        //databasesList.databases.forEach(db => console.log(` - ${db.name}`));

        const cursor = await users.find(query, options).toArray();
        console.log('after=?');
        //for await (const doc of cursor) {
        //    console.dir(doc);
        //  }
        res.send({danger: true, outcome: cursor});
        //var tmp;
        //console.log('try=?');
        //await users.findOne({}, function(err, result) {
        //    if (err) 
        //        console.log(err);
        //    console.log('succes=?');
        //    console.log(result.username);
        //    tmp = result.username;
        //});
    } catch (e) {
        console.error(e);
    } finally {
        await client.close();
    }
    //res.send({danger: true, result_is: tmp});
    });


app.post('/login', async (req, res, next) => { 
    const {identifier, password} = await req.body;
    // check if identifier, password and name send by request
    if(!identifier || !password)
    {
        return res.status(400).send({message: "Mail or password missing!"});
    }

    const user = users.find(user => user.username == identifier);

    if(!user)
        return res.status(400).send('Can not find user!');

    try
    {
        if(await bcrypt.compare(password, user.password))
        {
        const [a, b, token] = await tkn.CreateToken(user);
        const [return_code, message, validation_rsa, validation_jwt] = await tkn.VerifyToken(token);
        res.json({token : token, is_token_rsa_valid: validation_rsa, is_token_jwt_valid: validation_jwt});
            
        }
        else
        {
            res.status(400).send('Password is not matching.');
        }
    }
    catch(error)
    {
        return res.status(500).send('Service not working.' +  error.message);
    }

})


app.post('/register', async (req, res) => {
    const {username, mail, password} = req.body;

    // check if email, password and name send by request
    if(!username || !mail || !password)
    {
        return res.status(400).send({message: "Mail or password missing!"});
    }

    // check if email is valid

    // check database if user already exists

    try
    {
        const hashed_password = await bcrypt.hash(req.body.password, 10);
        console.log(hashed_password);     
        res.status(200).send({username: username, mail: mail, password:hashed_password});
    }
    catch
    {
        res.status(500).send();
    }

    return res.status(201).send();

    
})

app.post('/users', async (req, res) => {
    try
    {
        const hashed_password = await bcrypt.hash(req.body.password, 10);
        console.log(req.body.username);
        console.log(hashed_password);     
        res.status(200).send();
    }
    catch
    {
        res.status(500).send();
    }
})



app.listen(port, () => 
    {
        console.log(`Auth server is running on port ${port}`);
    }
);
*/