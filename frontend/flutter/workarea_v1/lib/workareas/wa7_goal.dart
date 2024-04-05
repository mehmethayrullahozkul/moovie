import 'package:flutter/material.dart';
import 'package:workarea_v1/workareas/wa_goal_template.dart';

class WA7Goal extends StatelessWidget {
  static const index = 7;
  const WA7Goal({super.key});
  @override
  Widget build(BuildContext context) {
    return const WAGoalTemplate(pageIndex: index, child: _Goal());
  }
}

class _Goal extends StatelessWidget {
  const _Goal({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Goal for WA7"),
    );
  }
}
