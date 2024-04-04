import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v1/workareas/wa_template.dart';

class WA1 extends StatelessWidget {
  static const index = 1;
  const WA1({super.key});

  @override
  Widget build(BuildContext context) {
    return WATemplate(
      pageIndex: index,
    );
  }
}
