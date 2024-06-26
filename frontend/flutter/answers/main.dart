import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<User> exampleListOfUsers = [
  User(name: "Example1", icon: Icons.abc),
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
            // TODO : implement the IndexScreen here, IndexScreen should take in the usersManager as a parameter
            return Container();
          },
          // TODO : implement rest of the routes here:
          // routes: []
        ),
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
