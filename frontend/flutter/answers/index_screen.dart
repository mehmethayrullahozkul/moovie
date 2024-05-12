import 'package:demo_v1/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IndexScreen extends StatefulWidget {
  final UsersManager usersManager;
  const IndexScreen({super.key, required this.usersManager});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final Color darkThemeForegroundColor = Color.fromARGB(255, 231, 231, 231);

  final Color lightThemeForegroundColor = Color.fromARGB(255, 19, 19, 19);

  final Color darkThemeBackgroundColor = const Color.fromARGB(255, 20, 20, 20);

  final Color lightThemeBackgroundColor = Color.fromARGB(255, 252, 252, 252);

  bool isDarkTheme = false;

  void _changeTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkTheme
              ? darkThemeBackgroundColor
              : lightThemeBackgroundColor,
          scrolledUnderElevation: 0,
          title: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Whatsdown App',
                style: TextStyle(
                    color: isDarkTheme
                        ? darkThemeForegroundColor
                        : lightThemeForegroundColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500)),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.change_circle,
                  color: isDarkTheme
                      ? darkThemeForegroundColor
                      : lightThemeForegroundColor,
                ),
                onPressed: () {
                  _changeTheme();
                }),
          ],
        ),
        body: ListView(
          children: List.generate(widget.usersManager.userCount, (index) {
            final user = widget.usersManager.users[index];
            return Material(
              color: isDarkTheme
                  ? darkThemeBackgroundColor
                  : lightThemeBackgroundColor,
              child: InkWell(
                onTap: () {
                  GoRouter.of(context).go('/${user.name}');
                },
                child: Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Icon(
                              user.icon,
                              color: isDarkTheme
                                  ? darkThemeForegroundColor
                                  : lightThemeForegroundColor,
                            ),
                            SizedBox(width: 30.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: TextStyle(
                                      color: isDarkTheme
                                          ? darkThemeForegroundColor
                                          : lightThemeForegroundColor),
                                ),
                                Text(
                                  user.messageCount == 0
                                      ? 'No Messages'
                                      : 'Latest Message: ${user.messages.last}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: isDarkTheme
                                          ? darkThemeForegroundColor
                                          : lightThemeForegroundColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text(
                          '${user.messageCount}',
                          style: TextStyle(
                              color: isDarkTheme
                                  ? darkThemeForegroundColor
                                  : lightThemeForegroundColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
