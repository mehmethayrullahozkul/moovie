import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WAGoalTemplate extends StatelessWidget {
  final int pageIndex;
  final Widget? child;

  const WAGoalTemplate({super.key, required this.pageIndex, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goal $pageIndex'),
        actions: [
          TextButton(
            child: const Text('Go Back to Menu'),
            onPressed: () {
              GoRouter.of(context).restore(RouteMatchList.empty);
            },
          ),
        ],
      ),
      body: child,
    );
  }
}
