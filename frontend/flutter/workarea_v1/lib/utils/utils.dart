import 'dart:math' as math;
import 'package:flutter/material.dart';

Color generateRandomWhitishColor(
    {double opacity = 1,
    int start = 200,
    int preference = 0,
    int subPreference = 0,
    double prominance = 1}) {
  final int subNext = ((1 - prominance) * start).toInt() + 1;
  final int next = 256 - start;
  const Color.fromARGB(255, 226, 157, 6);
  switch (preference) {
    case 0:
      {
        switch (subPreference) {
          case 0:
            {
              final int red = start + math.Random().nextInt(next);
              final int green = math.Random().nextInt(subNext);
              final int blue = math.Random().nextInt(subNext);
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 1:
            {
              final int red = start + math.Random().nextInt(next);
              final int green = subNext + math.Random().nextInt(next);
              final int blue = math.Random().nextInt(subNext);
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 2:
            {
              final int red = start + math.Random().nextInt(next);
              final int green = math.Random().nextInt(subNext);
              final int blue = subNext + math.Random().nextInt(next);
              return Color.fromRGBO(red, green, blue, opacity);
            }
        }
      }
    case 1:
      {
        switch (subPreference) {
          case 0:
            {
              final int red = subNext + math.Random().nextInt(next);
              final int green = start + math.Random().nextInt(next);
              final int blue = math.Random().nextInt(subNext);
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 1:
            {
              final int red = math.Random().nextInt(subNext);
              final int green = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int blue = math.Random().nextInt(subNext);
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 2:
            {
              final int red = math.Random().nextInt(subNext);
              final int green = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int blue = subNext + math.Random().nextInt(next);
              return Color.fromRGBO(red, green, blue, opacity);
            }
        }
      }
    case 2:
      {
        switch (subPreference) {
          case 0:
            {
              final int red = subNext + math.Random().nextInt(next);
              final int green = math.Random().nextInt(subNext);
              final int blue = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 1:
            {
              final int red = math.Random().nextInt(subNext);
              final int green = subNext + math.Random().nextInt(next);
              final int blue = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 2:
            {
              final int red = math.Random().nextInt(subNext);
              final int green = math.Random().nextInt(subNext);
              final int blue = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
        }
      }
  }
  return Color.fromRGBO(255, 255, 255, opacity);
}

Color generateRandomColor() {
  return Color.fromRGBO(math.Random().nextInt(256), math.Random().nextInt(256),
      math.Random().nextInt(256), 1);
}
