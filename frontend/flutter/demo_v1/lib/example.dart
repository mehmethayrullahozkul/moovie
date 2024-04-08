import 'package:flutter/material.dart';

/*
 * Introduction to Sending Passing Widgets Between Classes
 * 
 * This simple example shows how to pass widgets as parameters to other classes.
*/

// Example Single Widget

Widget exampleSingleWidget = Container(
  color: Colors.amber,
  alignment: Alignment.center,
  child: Text(
    "Im an example widget",
    textAlign: TextAlign.center,
  ),
);

// Example List Of Widgets

List<Widget> exampleListOfWidgets = [
  Container(
    color: Colors.red,
    child: Text("An Example Widget from List 1"),
  ),
  Container(
    color: Colors.blue,
    child: Text("An Example Widget from List 2"),
  ),
  Container(
    color: Colors.green,
    child: Text("An Example Widget from List 3"),
  ),
];

List<MySimpleClass> exampleListOfSimpleClassObjects = [
  MySimpleClass(
      name: "Example simple class object name 1", color: Colors.amberAccent),
  MySimpleClass(
      name: "Example simple class object name 2", color: Colors.lightGreen),
  MySimpleClass(
      name: "Example simple class object name 3", color: Colors.pinkAccent),
];

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.6,
              fontSizeDelta: 3.0,
            ),
      ),
      home: Scaffold(
          body: MyOwnSpecialWidget(
              singleChild: exampleSingleWidget,
              listOfChild: exampleListOfWidgets,
              listOfBasicClass: exampleListOfSimpleClassObjects)),
    );
  }
}

class MyOwnSpecialWidget extends StatelessWidget {
  /* here we can declare any class spesific fields */
  final Widget singleChild;
  final Widget singleDefaultedChild;
  final List<Widget> listOfChild;
  final List<MySimpleClass> listOfBasicClass;

  MyOwnSpecialWidget(
      {super.key,
      required this.singleChild,

      // Here we provided default value to this value and the default value MUST BE a constant value.
      // If parameter is provided while creating the object default value will be OVERRIDDEN.
      this.singleDefaultedChild = const Align(
          alignment: Alignment.center,
          child: Text(
            "Im Defaulted If Parameter Not Given",
            textAlign: TextAlign.center,
          )),
      required this.listOfChild,
      required this.listOfBasicClass});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: singleChild),
        Expanded(child: singleDefaultedChild),
        Expanded(
            child: Column(
          children: listOfChild,
        )),
        Expanded(
            child: Row(
          children: List.generate(listOfBasicClass.length, (index) {
            return Expanded(
              child: Container(
                color: listOfBasicClass[index].color,
                child: Text(listOfBasicClass[index].name),
              ),
            );
          }),
        ))
      ],
    );
  }
}

class MySimpleClass {
  final String name;
  final Color color;

  MySimpleClass({required this.name, required this.color});
}
