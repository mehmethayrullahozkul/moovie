import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v1/workareas/wa_template.dart';

class WA3 extends StatelessWidget {
  static const index = 3;
  const WA3({super.key});
  @override
  Widget build(BuildContext context) {
    return WATemplate(
      pageIndex: index,
      child: _SolutionWidget(),
    );
  }
}

class _SolutionWidget extends StatefulWidget {
  _SolutionWidget({super.key});

  @override
  State<_SolutionWidget> createState() => _SolutionWidgetState();
}

class _SolutionWidgetState extends State<_SolutionWidget> {
  late int result;

  late TextEditingController _controller1;

  late TextEditingController _controller2;
  
  String text = "NONE";
  
  @override
  void initState(){
    result = 10;
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
  }
  int Calculator() {
  int? num1 = int.tryParse(_controller1.text);
  int? num2 = int.tryParse(_controller2.text);

  if (text == "ADD") {
    result = num1! + num2!;
  } else if (text == "SUBSTRACT") {
    result = num1! - num2!;
  } else if (text == "MULTIPLY") {
    result = num1! * num2!;
  } else if (text == "DIVIDE") {
    result = (num1! / num2!).toInt();
  }
  return result;
}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height : 40,
          width : 200,
          ),
          SizedBox (
          height : 70,
          width : 250,
           child : TextField(
                  controller: _controller1,
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
          SizedBox(
            height : 70,
          width : 200,
          ),
         SizedBox(
          height : 40,
          width : 250,
          child : TextField(
                  controller: _controller2,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      hintText: "Enter the second number",
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
           SizedBox(
            height : 70,
          width : 200,
          ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            InkWell(
              onTap: () {
                setState(() {
                  text = "ADD";
                });
              } ,
              child: Container(
                padding: EdgeInsets.all(10),       
                alignment: Alignment.center,         
                height: 40,
                width : 50,
               clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color.fromARGB(255, 204, 203, 203),),
                child: Text( 
                  "+" ,style: TextStyle(fontSize: 20 ,  color: Color.fromARGB(255, 2, 70, 146)),
                 
                ),
              )
            ),
            InkWell(
              onTap: () {
                setState(() {
                  text = "SUBSTRACT";
                });
              } ,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color.fromARGB(255, 204, 203, 203),),
                padding: EdgeInsets.all(10),       
                alignment: Alignment.center,         
                height: 40,
                width : 50,
                
                child: Text( 
                  "-" ,style: TextStyle(fontSize: 20 , color: Color.fromARGB(255, 2, 70, 146)),
                 
                ),
              )
            ),
            InkWell(
              onTap: () {
                setState(() {
                  text = "MULTIPLY";
                });
              } ,
              child: Container(
                padding: EdgeInsets.all(10),       
                alignment: Alignment.center,         
                height: 40,
                width : 50,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color.fromARGB(255, 204, 203, 203),),
                child: Text( 
                  "*" ,style: TextStyle(fontSize: 20 , color: Color.fromARGB(255, 2, 70, 146)),
                 
                ),
              )
            ),
           InkWell(
              onTap: () {
                setState(() {
                  text = "DIVIDE";
                });
              } ,
              child: Container(
                padding: EdgeInsets.all(10),       
                alignment: Alignment.center,         
                height: 40,
                width : 50,
               clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color.fromARGB(255, 204, 203, 203),),
                child: Text( 
                  "/" ,style: TextStyle(fontSize: 20 , color: Color.fromARGB(255, 2, 70, 146)),
                 
                ),
              )
            ),
            
          ]
         ),
         Container(
          height : 50,
          ),Text(
           "Selected Operation:${text}" ,style: TextStyle(fontSize: 20 , color: Color.fromARGB(255, 2, 70, 146)),
           ),
           SizedBox(
            height: 25,
           ),
           ElevatedButton(
            onPressed: () {
            
              int result = Calculator();
              setState(() {
                
              });

            
                      },
            child : Column(
              children: [
          
          Container(
            child: Text(
              "Calculate",
            )
          )
              ]
            )
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              child: Text(
                "Result is ${result}",
              )
          )
        ]
      )
      
      
    );
  }
}


// Margin
// Border
// Padding 20 - Height 20
// Content 0