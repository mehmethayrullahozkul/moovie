import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v1/workareas/wa_template.dart';

class WA8 extends StatelessWidget {
  static const index = 8;
  const WA8({super.key});
  @override
  Widget build(BuildContext context) {
    return const WATemplate(pageIndex: index);
  }
}
