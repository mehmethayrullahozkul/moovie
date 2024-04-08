import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

List<User> exampleListOfUsers = [
  User(name: "Taha", icon: Icons.abc),
  User(name: "Example2", icon: Icons.abc),
  User(name: "Example3", icon: Icons.abc),
  User(name: "Example4", icon: Icons.abc),
  User(name: "Example5", icon: Icons.abc),
  User(name: "Example6", icon: Icons.abc),
  User(name: "Example7", icon: Icons.abc),
  User(name: "Example8", icon: Icons.abc),
  User(name: "Example9", icon: Icons.abc),
  User(name: "Example10", icon: Icons.abc),
  User(name: "Example11", icon: Icons.abc),
  User(name: "Example12", icon: Icons.abc),
  User(name: "Example13", icon: Icons.abc),
  User(name: "Example14", icon: Icons.abc),
  User(name: "Example15", icon: Icons.abc),
  User(name: "Example16", icon: Icons.abc),
  User(name: "Example20", icon: Icons.abc),
  User(name: "Example21", icon: Icons.abc),
  User(name: "Example22", icon: Icons.abc),
  User(name: "Example23", icon: Icons.abc),
];

void main() {
  runApp(WhatsdownApp());
}

class WhatsdownApp extends StatefulWidget {
  WhatsdownApp({super.key});

  @override
  State<WhatsdownApp> createState() => _WhatsdownAppState();
}

class _WhatsdownAppState extends State<WhatsdownApp> {
  late final UsersManager usersManager;
  late final GoRouter routerConfig;

  @override
  void initState() {
    super.initState();
    usersManager = UsersManager(users: exampleListOfUsers);

    routerConfig = GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return IndexScreen();
          },
        ),
        ...List.generate(22, (index) {
          return GoRoute(
            path: '/message${index + 1}',
            builder: (context, state) {
              return Messages(person: exampleListOfUsers[index]);
            },
          );
        })

        // Add more routes as needed
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: 1.2,
                fontSizeDelta: 2.0,
              ),
        ),
        routerConfig: routerConfig);
  }
}

class IndexScreen extends StatefulWidget {
  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          color: Colors.white,
          child: ListView(children: [
            ...List.generate(exampleListOfUsers.length, (index) {
              return InkWell(
                onTap: () {
                  GoRouter.of(context).push("/message${index + 1}");
                },
                child: SizedBox(
                    height: 70,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Icon(
                              exampleListOfUsers[index].icon,
                            ),
                          ),
                          Column(children: [
                            Text(
                              exampleListOfUsers[index].name,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Text(
<<<<<<< HEAD
                              exampleListOfUsers[index].messageCount != 0 ?
                              "Latest Message : ${exampleListOfUsers[index].messages[exampleListOfUsers[index].messageCount-1]}"
                                : "No Messages",
=======
                              "${exampleListOfUsers[index].messageCount} Messages",
>>>>>>> development
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black),
                            )
                          ]),
                          SizedBox(
                            width: 50,
                          ),
                          Text("${exampleListOfUsers[index].messageCount}",
                              style: TextStyle(fontSize: 25))
                        ])),
              );
            })
          ])),
    );
  }
}

class Messages extends StatefulWidget {
  final User person;

  Messages({required this.person});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.person.name, style: TextStyle(fontSize: 25)),
        ),
        body: SafeArea(
          child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1,
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Icon(widget.person.icon, size: 50)),
                    Text("${widget.person.messageCount} New Messages",
                        style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.person.messageCount++;
                            setState(() {});
                          },
                          child: Text("Add Message",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 74, 10, 146))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.person.messageCount = 0;
                            setState(() {});
                          },
                          child: Text("Clear Messages",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 74, 10, 146))),
                        ),
                      ),
                    ),
                    ...List.generate(widget.person.messageCount, (index) {
                      return SizedBox(
                        height: 56,
                        child: Text("New Message ${index + 1}",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      );
                    })
                  ])),
        ));
  }
}

// USER CLASS

class User {
  final String name;
  final IconData icon;
  int messageCount;
  List<String> messages = [];

  User({
    required this.name,
    required this.icon,
    this.messageCount = 0,
  });

  void addMessage(String message) {
    messages.add(message);
    messageCount++;
  }

  void clearMessages() {
    messages.clear();
    messageCount = 0;
  }
}

class UsersManager {
  List<User> users;

  UsersManager({required this.users});

  int get userCount => users.length;

  void addUser(User user) {
    users.add(user);
  }

  void removeUser(User user) {
    users.remove(user);
  }

  User getUser(String name) {
    return users.firstWhere((element) => element.name == name);
  }
}
