import 'package:flutter/material.dart';
import 'package:workarea_v1/workareas/wa_goal_template.dart';

class WA8Goal extends StatelessWidget {
  static const index = 8;
  const WA8Goal({super.key});
  @override
  Widget build(BuildContext context) {
    return const WAGoalTemplate(pageIndex: index, child: _Goal());
  }
}

class _Goal extends StatelessWidget {
  const _Goal({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Goal for WA8"),
      ),
    );
  }
}
