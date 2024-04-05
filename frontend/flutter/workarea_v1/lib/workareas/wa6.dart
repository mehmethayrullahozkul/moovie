import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v1/workareas/wa_template.dart';

class WA6 extends StatelessWidget {
  static const index = 6;
  const WA6({super.key});

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
    return const Scaffold(
      body: Center(
        child: Text("Change here with solution for WA6"),
      ),
    );
  }
}
