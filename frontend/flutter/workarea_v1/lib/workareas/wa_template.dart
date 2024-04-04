import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WATemplate extends StatelessWidget {
  final int pageIndex;
  final Widget? child;

  const WATemplate({super.key, required this.pageIndex, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Area $pageIndex'),
        actions: [
          TextButton(
            child: const Text('Goal'),
            onPressed: () {
              GoRouter.of(context).push('/work-area-$pageIndex/goal');
            },
          ),
        ],
      ),
      body: child,
    );
  }
}
