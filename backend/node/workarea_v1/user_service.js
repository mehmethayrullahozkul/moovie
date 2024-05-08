class UserService {

  users = [];

  constructor() {
    this.users = [];
  }

  addUser(user) {
    if(typeof user === 'object' && user instanceof User)
    {
      this.users.push(user);
    }
  }

  getUser(username) {
    return this.users.find(user => user.username === username) || null;
  }

  hasUser(username) {
    return (this.users.find(user => user.username === username) === undefined ? false : true);
  }

  authenticateUser(username, password) {
    return (this.users.find(user => user.username === username && user.password === password) === undefined ? false : true);
  }


  getUserByUsername(username) {
    return (this.users.find(user => user.username === username) === undefined ? null : this.users.find(user => user.username === username));
  }


  getUsers() {
    return this.users;
  }
}

class User {

  username = '';
  mail = '';
  password = '';
  #secretData = '';

  get secretData() {
    return this.#secretData;
  }

  constructor(username, mail, password, secretData) {
    this.username = username;
    this.mail = mail;
    this.password = password;
    this.#secretData = secretData;
  }
}

const userService = new UserService();

userService.addUser(new User('ali', 'ali@gmail.com', '123456', 'ali has something to hide'));
userService.addUser(new User('mehmet', 'mehmet@gmail.com', '123456', 'mehmet was a bully in school'));
userService.addUser(new User('furkan', 'furkan@gmail.com', '123456', 'furkan is someone who loves to play games'));
userService.addUser(new User('taha', 'taha@gmail.com', '123456', 'taha is a person who loves to play guitar'));

module.exports = userService;