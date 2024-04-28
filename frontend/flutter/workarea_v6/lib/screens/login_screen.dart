

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workarea_v6/blocs/giris/giris_state.dart';
import 'package:workarea_v6/blocs/giris/giris_bloc.dart';
import 'package:workarea_v6/blocs/giris/giris_event.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      
      body: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.84,
        child:Column(
          children: [           
            Padding(
              padding:EdgeInsets.only(top: 60),
              child: 
            TextField(
              controller: _usernameController,             
            )),
             Padding(
              padding:EdgeInsets.only(top: 60),
              child: 
            TextField(
              controller: _passwordController,             
            )), 
            Padding(
              padding: EdgeInsets.only(top: 60),
              child: ElevatedButton(onPressed: () =>
                          BlocProvider.of<GirisBloc>(context).add(
                              GirisButtonPressed(
                                  username: _usernameController.text,
                                  password: _passwordController.text)),
                      child: Text('Login')),
            ),
            ElevatedButton(
              onPressed: () => {
                
                GoRouter.of(context).push("/data"),
              },
              child: Text("Data Ekranina git")
              ,
            ),
                BlocBuilder<GirisBloc, GirisState>(
                    builder: (context, state) {
                  print("Current Auth State is:  $state");
                  if (state is GirisYapilmadi) {
                    return Text('Login failed');
                  } else if (state is GirisYapiliyor) {
                    return Text('Login loading');
                  } else if (state is GirisYapilmadi) {
                    return Text('Login inital state');
                  } else if (state is GirisYapildi) {
                    return Text('Login successful');
                  }
                  return Container();
                }
                
                ) ,               
          ],
          )
      ),

    );
  }
}
