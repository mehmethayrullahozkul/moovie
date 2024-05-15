var loki=require('lokijs');

var db = new loki('example.db');


const userschema = {
    version: 0,
    primaryKey: 'id',
    type: 'object',
    properties: {
        id: {
            type: 'string',
            maxLength: 100 
        },
        username: {
            type: 'string'
        },
        password: {
            type: 'string'
        },
        mail: {
            type: 'string'
        },
        secretdata: {
            type: 'string'
        },
        todo: {
            properties: {
                count: {
                    type: 'string'
                },
                list: {
                    type: 'array',
                    items: {
                        type: 'string'
                }
            
            },
        },
        done: {
            type: 'boolean'
        },
    },
    required: ['id', 'username', 'password', 'mail', 'secretdata', 'done'],
    }
}


    const users =  db.addCollection({
        name: 'users',
        options: {
            unique: ['username', 'id', ], 
           
            autoupdate: true
            
        },
    
    });

/* users.insert({
    username: 'ali',
    password: '123456',
    mail: 'ali@gmail.com',
    secretdata: 'ali has something to hide',
    todo: {
        count: 0,
        list: [],
    },
    done: true
});

users.insert({
    username: 'mehmet',
    password : '123456',
    mail: 'mehmet@gmail.com',
    secretdata: 'mehmet was a bully in school',
    todo: {
        count: 0,
        list: [
            
        ],
    },
    done: true
});

users.insert({
    username: 'furkan',
    password: '123456',
    mail: 'furkan@gmail.com',
    secretdata: 'furkan is someone who loves to play games',
    todo: {
        count: 0,
        list: [
            
        ],
    },

    done: true
});

users.insert({
    username: 'taha',
    password: '123456',
    mail: 'taha@gmail.com',
    secretdata: 'taha is a person who loves to play guitar',
    todo: {
        count: 0,
        list: [
        ],
    },
    done: true
}); */



module.exports =  users;