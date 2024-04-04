import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v1/workareas/wa_template.dart';

class WA4 extends StatelessWidget {
  static const index = 4;
  const WA4({super.key});
  @override
  Widget build(BuildContext context) {
    return const WATemplate(pageIndex: index);
  }
}
