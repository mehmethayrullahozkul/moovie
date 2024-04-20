import 'package:flutter/material.dart';


abstract class ColorEvent {}

class ColorChangedEvent extends ColorEvent {
  final int color;

  ColorChangedEvent(this.color);
}
