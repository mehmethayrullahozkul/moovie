import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:workarea_v1/workareas/wa_goal_template.dart';

class WA5Goal extends StatelessWidget {
  static const index = 5;
  const WA5Goal({super.key});

  @override
  Widget build(BuildContext context) {
    return const WAGoalTemplate(pageIndex: index, child: _Goal());
  }
}

class _Goal extends StatelessWidget {
  const _Goal({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
        /* scrollDirection property of the ListView widget, it expects an Axis enum value */
        scrollDirection: Axis.vertical,

        /* padding property of the ListView widget, it expects an EdgeInsets object */
        padding: EdgeInsets.zero,

        /* children property of the ListView widget, it expects a list of widgets */
        children:
            /* 
               * List.generate
               * params: itemCount, itemBuilder
               * returns: List<Widget>
               * 
               * List.generate is a method that generates a list of widgets based on the itemCount and itemBuilder.
               * itemCount is the number of widgets to generate.
               * itemBuilder is a function that generates a widget based on the index.
               * itemBuilder is called itemCount times.
              */
            [
          AppBar(
            /* Background Color property of the AppBar widget */
            backgroundColor: const Color.fromARGB(255, 20, 20, 20),

            /* Bilmesen de olur, elevation property of the AppBar widget */
            scrolledUnderElevation: 0,

            /* Title property of the AppBar widget, it expects a widget to render at the title space */
            title: const Padding(
              /* Padding widget is used to add padding to the child widget */
              padding: EdgeInsets.only(left: 20.0),

              /* Text widget is used to render text */
              child: Text('Moovie',

                  /* TextStyle is used to style the text */
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 22,
                      fontWeight: FontWeight.w500)),
            ),

            /* Actions property of the AppBar widget, it expects a list of widgets to render at the end of the app bar */
            actions: [
              IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    print('Search button pressed');
                  }),
              IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print('More button pressed');
                  }),
            ],
          ),
          ...List.generate(20, (index) {
            /* index is representing the nth object created */
            /* math.Random is a class that is used to generate random numbers */
            int randomBackgroundColorValue = math.Random().nextInt(10) + 40;
            Color randomBackgroundColor = Color.fromARGB(
                255,
                randomBackgroundColorValue,
                randomBackgroundColorValue,
                randomBackgroundColorValue);

            /* Material is a widget that is used to provide material design to its children right below */
            /* InkWell is a widget used to handle user touch and tapping, its used with material to create a splash effect */
            return Material(
              color: randomBackgroundColor,

              /* child property of the Material widget, it expects a widget */
              child: InkWell(
                /* splashColor property of the InkWell widget, it expects a color */
                splashColor: Colors.white.withOpacity(0.2),

                /* onTap property of the InkWell widget, it expects a function to run when clicked */
                onTap: () {
                  /*  scaffoldMessengerKey.currentState!.showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      duration: const Duration(milliseconds: 300),
                      content: Text('You have clicked on item $index'),
                    ),
                  ); */
                },

                /* 
                 * SizedBox is a widget that is used to set the size of its child 
                 * It try to make its child widget to have the given width and height
                */
                child: SizedBox(

                    /* width trying to get maximum size it can get but since scaffold limits its width it can only get the max */
                    width: double.infinity,

                    /* height of the SizedBox widget */
                    height: 80,
                    child:

                        /* Padding widget is used to add padding to the child widget */
                        Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),

                      /* 
                          Row is a widget that is used to render its children in a horizontal line.
                          Bu Row widgetinin children property'sine bir liste veriyoruz ve bu listedeki her bir eleman yan yana renderlanıyor.
                          */
                      child: Row(
                        /* 
                          mainAxisAlignment property of the Row widget, it expects a MainAxisAlignment enum value 
                          Row widgetinin children'larını nasıl hizalayacağını belirler. 
                          */
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.movie_creation_outlined,

                                  /* random color for the icon */
                                  color: Color((math.Random().nextDouble() *
                                              0xFFFFFF)
                                          .toInt())
                                      .withOpacity(1.0)),

                              /* SizedBox is a widget that is used to add space between its children */
                              SizedBox(width: 20),
                              Text('This is the item $index',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }),
        ]);
  }
}
