import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:workarea_v1/utils/utils.dart';
import 'package:workarea_v1/workareas/wa_goal_template.dart';

class WA3Goal extends StatelessWidget {
  static const index = 3;
  const WA3Goal({super.key});
  @override
  Widget build(BuildContext context) {
    return const WAGoalTemplate(
      pageIndex: index,
      child: _Goal(),
    );
  }
}

enum Operation { NONE, ADD, SUBTRACT, MULTIPLY, DIVIDE }

class _Goal extends StatefulWidget {
  const _Goal({super.key});

  @override
  State<_Goal> createState() => _GoalState();
}

class _GoalState extends State<_Goal> {
  late TextEditingController _firstNumberController;
  late TextEditingController _secondNumberController;
  late int _result;
  late String _resultText;
  late Operation _selectedOperation;

  @override
  void initState() {
    _result = 0;
    _selectedOperation = Operation.NONE;
    _firstNumberController = TextEditingController();
    _secondNumberController = TextEditingController();
    _resultText = "";
    super.initState();
  }

  @override
  void dispose() {
    _firstNumberController.dispose();
    _secondNumberController.dispose();
    super.dispose();
  }

  void _reload() {
    _result = 0;
    _resultText = "";
    _firstNumberController.clear();
    _secondNumberController.clear();
    _selectedOperation = Operation.NONE;
    setState(() {});
  }

  void _changeOperation(Operation operation) {
    setState(() {
      _selectedOperation = operation;
    });
  }

  void _calculate() {
    int? num1 = int.tryParse(_firstNumberController.text);
    int? num2 = int.tryParse(_secondNumberController.text);
    if (num1 == null || num2 == null) {
      _resultText = "Please enter valid numbers";
      setState(() {});
      return;
    }

    switch (_selectedOperation) {
      case Operation.ADD:
        _result = num1 + num2;
        break;
      case Operation.SUBTRACT:
        _result = num1 - num2;

        break;
      case Operation.MULTIPLY:
        _result = num1 * num2;

        break;
      case Operation.DIVIDE:
        _result = (num1 / num2).floor();

        break;
      case Operation.NONE:
        _resultText = "Please select an operation";
        setState(() {});
        return;
    }
    _resultText = "Result: $_result";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        padding: const EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        width: double.infinity,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.84,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Calculator App",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Color.fromARGB(255, 22, 22, 22),
                          fontFamily: "Manjari"),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      iconSize: 24,
                      icon: Icon(Icons.refresh,
                          color: Color.fromARGB(255, 70, 70, 70)),
                      onPressed: () {
                        _reload();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TextField(
                  controller: _firstNumberController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      hintText: "Enter the first number",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 134, 44, 194),
                        fontFamily: "Sofia-Pro",
                        fontWeight: FontWeight.w300,
                      ),
                      focusedBorder: InputBorder.none),
                  style:
                      TextStyle(color: const Color.fromARGB(255, 34, 34, 34)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TextField(
                  controller: _secondNumberController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: "Enter the second number",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 134, 44, 194),
                      fontFamily: "Sofia-Pro",
                      fontWeight: FontWeight.w300,
                    ),
                    /* enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                    ), */
                    focusedBorder: InputBorder.none,
                  ),
                  style:
                      TextStyle(color: const Color.fromARGB(255, 41, 41, 41)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _changeOperation(Operation.ADD);
                          },
                          child: Text("+", style: TextStyle(fontSize: 24))),
                      ElevatedButton(
                          onPressed: () {
                            _changeOperation(Operation.SUBTRACT);
                          },
                          child: Text("-", style: TextStyle(fontSize: 24))),
                      ElevatedButton(
                          onPressed: () {
                            _changeOperation(Operation.MULTIPLY);
                          },
                          child: Text("*", style: TextStyle(fontSize: 24))),
                      ElevatedButton(
                          onPressed: () {
                            _changeOperation(Operation.DIVIDE);
                          },
                          child: Text("/", style: TextStyle(fontSize: 24))),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Selected operation: ${_selectedOperation.name}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 22, 22, 22),
                      fontFamily: "Manjari"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromARGB(255, 123, 35, 223),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: _calculate,
                        child: Container(
                            alignment: Alignment.center,
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 10.0),
                            width: double.infinity,
                            child: Text(
                              "Calculate",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Manjari"),
                            )))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  _resultText,
                  style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 22, 22, 22),
                      fontFamily: "Manjari"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
