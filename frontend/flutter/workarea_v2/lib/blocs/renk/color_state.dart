import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class ColorState extends Equatable {}

class ColorInitial extends ColorState {
  @override
  List<Object> get props => [];
}

class ColorLoading extends ColorState {
  @override
  List<Object> get props => [];
}

class ColorBlack extends ColorState {
  @override
  List<Object> get props => [];
}

class ColorWhite extends ColorState {
  @override
  List<Object> get props => [];
}

class ColorRed extends ColorState {
  @override
  List<Object> get props => [];
}
