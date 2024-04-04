import 'package:flutter/material.dart';
import 'package:workarea_v1/workareas/wa_goal_template.dart';

class WA5Goal extends StatelessWidget {
  static const index = 5;
  const WA5Goal({super.key});

  @override
  Widget build(BuildContext context) {
    return const WAGoalTemplate(pageIndex: index);
  }
}
