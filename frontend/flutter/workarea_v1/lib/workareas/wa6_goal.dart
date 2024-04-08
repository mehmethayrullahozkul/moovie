import 'package:flutter/material.dart';
import 'package:workarea_v1/utils/utils.dart';
import 'dart:math' as math;
import 'package:workarea_v1/workareas/wa_goal_template.dart';

class WA6Goal extends StatelessWidget {
  static const index = 6;
  const WA6Goal({super.key});

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
    double heightUnit = MediaQuery.of(context).size.height * 0.12;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Row(
              children: List.generate(4, (index) {
            return Expanded(
              child:
                  Container(height: heightUnit, color: generateRandomColor()),
            );
          })),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            flex: 1,
            child: Container(height: heightUnit, color: generateRandomColor()),
          ),
          Expanded(
            flex: 2,
            child: Container(height: heightUnit, color: generateRandomColor()),
          ),
          Expanded(
            flex: 3,
            child: Container(height: heightUnit, color: generateRandomColor()),
          ),
          Expanded(
            flex: 2,
            child: Container(height: heightUnit, color: generateRandomColor()),
          ),
          Expanded(
            flex: 1,
            child: Container(height: heightUnit, color: generateRandomColor()),
          )
        ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(4, (index) {
              return Expanded(
                flex: index + 1,
                child:
                    Container(height: heightUnit, color: generateRandomColor()),
              );
            })),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              flex: 1,
              child:
                  Container(height: heightUnit, color: generateRandomColor())),
          Spacer(
            flex: 2,
          ),
          Expanded(
              child:
                  Container(height: heightUnit, color: generateRandomColor())),
          Spacer(
            flex: 2,
          ),
          Expanded(
              child:
                  Container(height: heightUnit, color: generateRandomColor())),
          Spacer(
            flex: 2,
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              child:
                  Container(height: heightUnit, color: generateRandomColor())),
          Expanded(
              child:
                  Container(height: heightUnit, color: generateRandomColor())),
          Expanded(
              child:
                  Container(height: heightUnit, color: generateRandomColor())),
        ]),
      ],
    );
  }
}
