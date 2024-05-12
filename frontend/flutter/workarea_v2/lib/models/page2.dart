import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v2/blocs/renk/color_bloc.dart';
import 'package:workarea_v2/blocs/renk/color_event.dart';
import 'package:workarea_v2/blocs/renk/color_state.dart';
import 'package:workarea_v2/blocs/config/config_bloc.dart';
import 'package:workarea_v2/blocs/config/config_event.dart';
import 'package:workarea_v2/blocs/config/config_state.dart';
import 'package:workarea_v2/models/config/config.dart';

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
          BlocBuilder<ConfigBloc, ConfigState>(
            builder: (context, state) {
              late bool theme;
              late bool language;
              late int lang;
              if (state.configModel!.appTheme == 1) {
                theme = false;
              } else if (state.configModel!.appTheme == 2) {
                theme = true;
              }
              if (state.configModel!.language == 1) {
                language = false;
                lang = 1;
              } else if (state.configModel!.language == 2) {
                language = true;
                lang = 2;
              }
              return Container(
                  height: 300,
                  width: 300,
                  color: theme ? Colors.black : Colors.grey,
                  child: Column(
                    children: [
                      ElevatedButton(
              onPressed: () {
                
                BlocProvider.of<ConfigBloc>(context).add(ConfigChangedEvent(config: Config(appTheme : 1 , language : language ? 1 : 2,)));
              },
              child: Text(
                    language ? "Change to English" : "Türkçeye Çevir",
                    
                    ),
            ),
            
            ElevatedButton(
              onPressed: () {
                 BlocProvider.of<ConfigBloc>(context).add(ConfigChangedEvent(config: Config(appTheme : 2 , language : lang,)));
              },
              child: Text(
                    language ? "Karanlik Mod" : "Dark theme",
                    
                    ),
            ),
             ElevatedButton(
              onPressed: () {
                 BlocProvider.of<ConfigBloc>(context).add(ConfigChangedEvent(config: Config(appTheme : 1 , language : lang,)));
              },
              child:  Text(
                    language ? "Aydinlik Mod" : "Light theme",
                    
                    ),
            ),
                      Text(
                    language ? "Menüye dön" : "Return to Menu",
                    
                    ),
        ]),
                    
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
