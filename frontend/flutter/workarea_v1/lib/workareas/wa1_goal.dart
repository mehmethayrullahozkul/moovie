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
    int randomMainColorPicker = math.Random().nextInt(3);
    int randomSubColorPicker = math.Random().nextInt(3);
    mainColor = generateRandomWhitishColor(
        preference: randomMainColorPicker,
        subPreference: randomSubColorPicker,
        prominance: 0.5);
    return Scaffold(
      backgroundColor: mainColor,
      body: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              counter++;
            });
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
                padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width - 320) / 2,
                  right: (MediaQuery.of(context).size.width - 320) / 2,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        counter.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      _ColorfullButton1(),
                    ],
                  ),
                )),
          ),
        ),
      ),
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
    int randomMainColorPicker = math.Random().nextInt(3);
    int randomSubColorPicker = math.Random().nextInt(3);
    Color mainColor = generateRandomWhitishColor(
        preference: randomMainColorPicker,
        subPreference: randomSubColorPicker,
        start: 100,
        prominance: 0.5);
    return GestureDetector(
      onTap: () {
        setState(() {
          counter++;
        });
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          color: mainColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  counter.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                _ColorfullButton2(),
              ],
            ),
          )),
    );
  }
}

class _ColorfullButton2 extends StatefulWidget {
  const _ColorfullButton2({super.key});

  @override
  State<_ColorfullButton2> createState() => _ColorfullButton2State();
}

class _ColorfullButton2State extends State<_ColorfullButton2> {
  late int counter;

  @override
  void initState() {
    counter = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int randomMainColorPicker = math.Random().nextInt(3);
    int randomSubColorPicker = math.Random().nextInt(3);
    Color mainColor = generateRandomWhitishColor(
        preference: randomMainColorPicker,
        subPreference: randomSubColorPicker,
        start: 100,
        prominance: 0.5);
    return GestureDetector(
      onTap: () {
        setState(() {
          counter++;
        });
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.2,
          color: mainColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  counter.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
