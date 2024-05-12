import 'package:flutter/material.dart';
import 'package:workarea_v2/models/config/config.dart';

abstract class ConfigEvent {}

class ConfigChangedEvent extends ConfigEvent {

  final Config config;

  ConfigChangedEvent(
  {
    required this.config,
  });
}
