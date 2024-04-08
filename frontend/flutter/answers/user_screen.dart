import 'package:demo_v1/main.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  final User user;
  const UserScreen({super.key, required this.user});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: ListView(
        children: [
          Icon(widget.user.icon),
          Text('Messages: ${widget.user.messageCount}'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.user
                    .addMessage('New Message ${widget.user.messageCount}');
              });
            },
            child: Text('Add Message'),
          ),
          /*   ElevatedButton(
            onPressed: () {
              setState(() {
                widget.user.removeMessage('New Message');
              });
            },
            child: Text('Remove Message'),
          ), */
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.user.clearMessages();
              });
            },
            child: Text('Clear Messages'),
          ),
          ...List.generate(
            widget.user.messageCount,
            (index) => ListTile(
              title: Text(widget.user.messages[index]),
            ),
          ),
        ],
      ),
    );
  }
}
