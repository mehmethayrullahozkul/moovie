import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Go to Page "1'),
              onPressed: () {
                GoRouter.of(context).push('/page1');
              },
            ),
            ElevatedButton(
              child: Text('Go to Page "2"'),
              onPressed: () {
                GoRouter.of(context).push('/page2');
              },
            ),
          ],
        ),
      ),
    );
  }
}
