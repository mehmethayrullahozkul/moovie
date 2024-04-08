import 'package:flutter/material.dart';
import 'package:workarea_v1/utils/utils.dart';
import 'dart:math' as math;
import 'package:workarea_v1/workareas/wa_goal_template.dart';

class WA4Goal extends StatelessWidget {
  static const index = 4;
  const WA4Goal({super.key});

  @override
  Widget build(BuildContext context) {
    return const WAGoalTemplate(
      pageIndex: index,
      child: _Goal(),
    );
  }
}

class _Goal extends StatelessWidget {
  const _Goal({super.key});
  @override
  Widget build(BuildContext context) {
    double widthUnit = MediaQuery.of(context).size.width * 0.15;
    double heightUnit = widthUnit;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(4, (index) {
              return Container(
                width: widthUnit,
                height: heightUnit,
                color: generateRandomWhitishColor(prominance: 0.5),
              );
            })),
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(4, (index) {
              return Container(
                width: widthUnit,
                height: heightUnit,
                color: generateRandomWhitishColor(prominance: 0.5),
              );
            })),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                width: widthUnit,
                height: heightUnit,
                color: generateRandomWhitishColor(prominance: 0.5),
              );
            })),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              return Container(
                width: widthUnit,
                height: heightUnit,
                color: generateRandomWhitishColor(prominance: 0.5),
              );
            })),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) {
              return Container(
                width: widthUnit,
                height: heightUnit,
                color: generateRandomWhitishColor(prominance: 0.5),
              );
            })),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return Container(
                width: widthUnit,
                height: heightUnit,
                color: generateRandomWhitishColor(prominance: 0.5),
              );
            }))
      ],
    );
  }
}
