import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

List<User> exampleListOfUsers = List.generate(30, (index) {
  return User(name: generateRandomString(), icon: getRandomIcon());
});

/* List<User> exampleListOfUsers = [
  User(name: "Example1", icon: Icons.abc);
  User(name: "Example2", icon: Icons.abc);
  User(name: "Example3", icon: Icons.abc);
  User(name: "Example4", icon: Icons.abc);
  User(name: "Example5", icon: Icons.abc);
  User(name: "Example6", icon: Icons.abc);
  User(name: "Example7", icon: Icons.abc);
]; */

String generateRandomString() {
  int length = math.Random().nextInt(10) + 3;
  return String.fromCharCodes(
      List.generate(length, (index) => math.Random().nextInt(33) + 89));
}

IconData getRandomIcon() {
  final List<int> points = <int>[0xe0b0, 0xe0b1, 0xe0b2, 0xe0b3, 0xe0b4];
  const String chars = '0123456789ABCDEF';
  int length = 3;
  String hex = '0xe';
  while (length-- > 0) hex += chars[(math.Random().nextInt(16)) | 0];
  return IconData(int.parse(hex), fontFamily: 'MaterialIcons');
}

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
