import 'package:flutter/material.dart';
import 'package:workarea_v1/end_goal_screen.dart';
import 'dart:math' as math;
import 'package:workarea_v1/utils/utils.dart';
import 'package:workarea_v1/workareas/wa_goal_template.dart';

class WA1Goal extends StatelessWidget {
  static const index = 1;
  const WA1Goal({super.key});
  @override
  Widget build(BuildContext context) {
    return const WAGoalTemplate(
      pageIndex: index,
      child: _Goal(),
    );
  }
}

class _Goal extends StatefulWidget {
  const _Goal({super.key});

  @override
  State<_Goal> createState() => _GoalState();
}

class _GoalState extends State<_Goal> {
  late int counter;
  late Color mainColor;

  @override
  void initState() {
    counter = 0;
    mainColor = Colors.white;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int randomColorPicker = math.Random().nextInt(3);
    mainColor = generateRandomWhitishColor(preference: randomColorPicker);
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text("Reload All Page")),
          _ColorfullButton1(),
        ],
      )),
    );
  }
}

class _ColorfullButton1 extends StatefulWidget {
  const _ColorfullButton1({super.key});

  @override
  State<_ColorfullButton1> createState() => _ColorfullButton1State();
}

class _ColorfullButton1State extends State<_ColorfullButton1> {
  late int counter;

  @override
  void initState() {
    counter = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int randomColorPicker = math.Random().nextInt(3);
    Color mainColor = generateRandomWhitishColor(preference: randomColorPicker);
    return Container(
      color: mainColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              setState(() {
                counter++;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Text(
                "Reload Only Me $counter",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            )),
      ),
    );
  }
}
