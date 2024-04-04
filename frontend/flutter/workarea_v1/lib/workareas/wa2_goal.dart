import 'package:flutter/material.dart';
import 'package:workarea_v1/workareas/wa_goal_template.dart';

class WA2Goal extends StatelessWidget {
  static const index = 2;
  const WA2Goal({super.key});
  @override
  Widget build(BuildContext context) {
    return const WAGoalTemplate(pageIndex: index);
  }
}
