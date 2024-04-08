import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v1/workareas/wa_template.dart';
import 'dart:math' as math;
class WA5 extends StatelessWidget {
  static const index = 5;
  const WA5({super.key});
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
  String yazi = "Simgeye basilmadi";

  String LastButton(int index){
    String returnval = "Simge ${index+1} e tikladin";
    return returnval;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: Column(
           
        children: [
          Container(
            
            height: 65,
            width: double.infinity,
            color: const Color.fromARGB(255, 44, 39, 39),
            child :  Text(yazi,style: TextStyle(fontSize: 20 , color: Colors.grey),),
          ),
         
          ...List.generate(10, (index){
           int randomBackgroundColorValue = math.Random().nextInt(10) + 40;
            Color randomBackgroundColor = Color.fromARGB(
                255,
                randomBackgroundColorValue,
                randomBackgroundColorValue,
                randomBackgroundColorValue);
          return Container(
            
            color: randomBackgroundColor,
            width: double.infinity,
            height: 65,
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children :[
                  SizedBox(width : 5),
                 Icon(Icons.movie_creation_outlined,

                                  /* random color for the icon */
                                  color: Color((math.Random().nextDouble() *
                                              0xFFFFFF)
                                          .toInt())
                                      .withOpacity(1.0)),
                  InkWell(
                    onTap: () {
                      yazi = LastButton(index);
                      setState((){

                      });
                       
                    },
                    
                    child : Text("Bu Simge ${index+1}" ,style: TextStyle(color: Colors.grey),),
                  ),
                  SizedBox(
                    width : 80,),
                    SizedBox(
                    width : 20,),
                  Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                  SizedBox(
                    width: 5,
                  )

                ]
              )
          );} )
            
          

        ],
        )
    );
  }
}
