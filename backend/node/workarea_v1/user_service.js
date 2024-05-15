const users = require('./db.js');



class UserRepository {


  constructor() {
    this.addUserAsObject(new User('mehmet', 'mehmet@gmail.com', '123456', 'mehmet has something to hide', 0, []));
    this.addUserAsObject(new User('ali', 'ali@gmail.com', '123456', 'ali has something to hide', 0, []));
    this.addUserAsObject(new User('furkan', 'furkan@gmail.com', '123456', 'furkan has something to hide', 0, []));
    this.addUserAsObject(new User('taha', 'taha@gmail.com', '123456', 'taha has something to hide', 0, []));
  }

  addUserAsObject(user) {
    
    if(typeof user === 'object' && user instanceof User)
    {
      
      if(this.hasUser(user.username))
      {
        return false;
      }
      let todoList = [];
      for (const element of user.todoList) {
        const todo = {
          id: element.id,
          data: element.data
        };
        todoList.push(todo);
      }
      users.insert({
        id: user.username,
        username: user.username,
        password: user.password,
        mail: user.mail,
        secret: user.secret,
        todo: {
          count: user.todoCount,
          list: todoList,
        },
        done: false
      });
      return true;
    }
  }


  addUser(username, password, mail, secret, todoCount, todoListComing) { 
      if(this.hasUser(username))
      {
        return false;
      }
      let todoList = [];
      for (const element of todoListComing) {
        const todo = {
          id: element.id,
          data: element.data
        };
        todoList.push(todo);
      }
      users.insert({
        username: username,
        password: password,
        mail: mail,
        secret: secret,
        todo: {
          count: todoCount,
          list: todoList,
        },
        done: false
      });
      return true;
  }

  getUser(username) {
    return users.by('username', username);
  }

  getUserAsObject(username) {
    const user = this.getUser(username);
    if(user === undefined || user === null || user.length === 0)
    {
      return undefined;
    }
    let todoList = [];
    for (const element of user.todo.list) {
      const todo = new TODO(element.id, element.data);
      todoList.push(todo);
    }
    return new User(username, user.mail, user.password, user.secret, user.todo.count, todoList);
  }

  hasUser(username) {
    const user = users.find({username: username});
    if(user === null || user === undefined || user.length === 0)
    {
      return false;
    }
    return true;
  }

  authenticateUser(username, password) {
    const user = this.getUser(username);
    if(user === undefined)
    {
      return false;
    }
    if(user.password === password)
    {
      return true;
    }
    return false;
  }

  updateUser(user) {
    if(typeof user === 'object' && user instanceof User)
    {
      if(this.hasUser(user.username))
      {
    
        const user1 = this.getUser(user.username);
      
        const result = users.by('username', user.username);
        result.password = user.password;
        result.mail = user.mail;
        result.secret = user.secret;

        let todoList = [];
        for (const element of user.todoList) {
          const todo = {
            id: element.id,
            data: element.data
          };
          todoList.push(todo);
        }
      
        result.todo = {
          count: user.todoCount,
          list: todoList,
        };
        users.update(result);

        const user2 = this.getUser(user.username);
     

        const after = users.by('username', user.username);
   
        /* const result = users.findAndUpdate({username: user.username}, function(obj) {
          obj.password = user.password;
          obj.mail = user.mail;
          obj.secretdata = user.secretData;
          obj.todo = {
            count: user.todoCount,
            list: user.todoList,
          };
        }); */
        return true;
      }
      return false;
    }
  }



  getUsers() {
    return users.get('users');
  }
}


class TODO {
  data = '';
  id = '';
  date = '';

  constructor(id, data, date) {
    this.id = id;
    this.data = data;
    this.date = date;
  }
}


class User {

  username = '';
  mail = '';
  password = '';
  #secret = '';
  todoCount = 0;
  todoList = [];

  get secret() {
    return this.#secret;
  }

  set secret(value) {
    this.#secret = value;
  }

  hasTODO(todoID) {
    for (const element of this.todoList) {
      if (element.id === todoID) {
        return true;
      }
    }
    return false;
  }

  addTODO(todo){
    if(todo instanceof TODO)
    {
      this.todoList.push(todo);
      this.todoCount++;
    }
  }

  addTODOwithID(todoID, todoString, todoDate){
    if(!this.hasTODO(todoID))
    {
      const todo = new TODO(todoID, todoString, todoDate);
      this.todoList.push(todo);
      this.todoCount++;
      
    }
    
  }

  removeTODO(todoID){
    for (let i = 0; i < this.todoList.length; i++) {
      if (this.todoList[i].id === todoID) {
        this.todoList.splice(i, 1);
        this.todoCount--;
        return true;
      }
    }
    return false;
  }

  getTODOs(){
    return this.todoList;
  }

  updateTODO(todoID, todo){
    for (let i = 0; i < this.todoList.length; i++) {
      if (this.todoList[i].id === todoID) {
        this.todoList[i] = todo;
        return true;
      }
    }
    return false;
  }

  getTODOByID(todoID){
    for (const element of this.todoList) {
      if (element.id === todoID) {
        return element;
      }
    }
    return null;
  }


  constructor(username, mail, password, secret, todoCount, todoList) {
    this.username = username;
    this.mail = mail;
    this.password = password;
    this.#secret = secret;
    this.todoCount = todoCount;
    this.todoList = todoList;
  }
}

const userRepository = new UserRepository();


module.exports = userRepository;