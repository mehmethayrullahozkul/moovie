import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v2/blocs/renk/color_bloc.dart';
import 'package:workarea_v2/blocs/renk/color_event.dart';
import 'package:workarea_v2/blocs/renk/color_state.dart';

class Page2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<ColorBloc, ColorState>(
            builder: (context, state) {
              late Color color;

              if (state is ColorBlack) {
                color = Colors.black;
              } else if (state is ColorWhite) {
                color = Colors.white;
              } else if (state is ColorRed) {
                color = Colors.red;
              } else {
                color = Colors.grey;
              }

              return Container(
                height: 200,
                width: 200,
                color: color,
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/menu');
            },
            child: Text('Go to Menu'),
          ),
        ],
      ),
    );
  }
}
