import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v1/workareas/wa_template.dart';

class WA9 extends StatelessWidget {
  static const index = 9;
  const WA9({super.key});
  @override
  Widget build(BuildContext context) {
    return const WATemplate(
      pageIndex: index,
      child: _SolutionWidget(),
    );
  }
}

class _SolutionWidget extends StatelessWidget {
  const _SolutionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Change here with solution for WA9"),
    );
  }
}
