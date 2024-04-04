import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v1/utils/utils.dart';
import 'dart:math' as math;

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: ListView(
        children: [
          AppBar(
            backgroundColor: Color.fromARGB(255, 247, 247, 247),
            scrolledUnderElevation: 0,
            toolbarHeight: 70,
            title: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 43, 43, 43), width: 0.1)),
                ),
                child: Text(
                  'Moovie Work Areas',
                  style: TextStyle(
                      color: Color.fromARGB(255, 43, 43, 43),
                      fontFamily: 'Sofia-Pro',
                      fontWeight: FontWeight.w900,
                      fontSize: 30),
                ),
              ),
            ),
            titleSpacing: 20,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.94,
              height: 120 * 20,
              child: ListView(
                  physics: const ClampingScrollPhysics(),
                  itemExtent: 120,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  children: [
                    ...List.generate(20, (index) {
                      int rdPrimer = math.Random().nextInt(3);
                      int scPrimer = (rdPrimer + 1) % 3;
                      Color rdColor = generateRandomWhitishColor(
                          preference: rdPrimer,
                          subPreference: scPrimer,
                          prominance: 0.5);
                      Color scColor = generateRandomWhitishColor(
                          start: 150,
                          preference: rdPrimer,
                          subPreference: scPrimer,
                          prominance: 0.8);

                      return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient:
                                  LinearGradient(colors: [rdColor, scColor]),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(
                                      3, 5), // changes position of shadow
                                ),
                              ]),

                          /* width trying to get maximum size it can get but since scaffold limits its width it can only get the max */
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 4),
                          height: 100,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 71, 71, 71),
                                      width: 0.1),
                                  /* random color for the border */
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 0),
                                          Text('Work Area ${index + 1}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Nunito-Sans',
                                                  fontWeight: FontWeight.w800,
                                                  color: /* Color.fromARGB(
                                                      255, 19, 19, 19) */
                                                      Colors.white)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              GoRouter.of(context).push(
                                                  '/work-area-${index + 1}');
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 36, 36, 36)),
                                              child: Center(
                                                child: Text(
                                                  "Start",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              GoRouter.of(context).push(
                                                  '/work-area-${index + 1}/goal');
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 211, 59, 59),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Goal",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    }),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class MyVerticalText extends StatelessWidget {
  final Text text;

  const MyVerticalText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      children: text.data!
          .split("")
          .map((string) => Text(
                string,
                style: text.style,
              ))
          .toList(),
    );
  }
}
