import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workarea_v7/models/constants.dart';

class ActionBar extends StatelessWidget {
  final Function onChoose;
  final bool disabled;

  final Map<PlayType, IconData> mappingIcon = {
    PlayType.paper: FontAwesomeIcons.hand,
    PlayType.rock: FontAwesomeIcons.handBackFist,
    PlayType.scissors: FontAwesomeIcons.handScissors,
  };

  ActionBar({
    required this.onChoose,
    required this.disabled,
  });

  Widget _renderIconButton(PlayType actionType) {
    final icon = Icon(
      mappingIcon[actionType],
      size: 32,
    );

    return IconButton(
      onPressed: disabled
          ? null
          : () {
              onChoose(actionType);
            },
      icon: icon,
    );
  }

  Widget _renderAction({
    required PlayType actionType,
    bool needRotate = false,
  }) {
    return Container(
      height: 64,
      width: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xfff9d835),
        borderRadius: BorderRadius.circular(
          32,
        ),
      ),
      child: needRotate
          ? Transform.rotate(
              angle: 1.5,
              child: _renderIconButton(actionType),
            )
          : _renderIconButton(actionType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _renderAction(
            actionType: PlayType.rock,
          ),
          _renderAction(
            actionType: PlayType.paper,
          ),
          _renderAction(
            actionType: PlayType.scissors,
            needRotate: true,
          ),
        ],
      ),
    );
  }
}
