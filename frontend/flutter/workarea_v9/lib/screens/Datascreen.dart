import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workarea_v9/Blocs/SecretDataBloc/SecretDataBloc.dart';
import 'package:workarea_v9/Blocs/SecretDataBloc/SecretDataEvent.dart';
import 'package:workarea_v9/Blocs/SecretDataBloc/SecretDataState.dart';
import 'package:workarea_v9/Blocs/authentication_bloc.dart';
import 'package:workarea_v9/Blocs/authentication_event.dart';
import 'package:workarea_v9/Blocs/authentication_state.dart';
import 'package:workarea_v9/Service/AuthenticationService.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(UnbuttonPressedevent());
                //   BlocProvider.of<SecretDataBloc>(context).add(ResetSecretData());
              },
              child: Text("Go to menu screen"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<SecretDataBloc>(context)
                    .add(SecretDataRequested());
              },
              child: Text("Get the value of secret data"),
            ),
          ),
          BlocBuilder<SecretDataBloc, SecretDataState>(
              builder: (context, state) {
            if (state is SecretDataUninitialized) {
              return const Text("Secret Data Uninitialized");
            } else if (state is SecretDataLoaded) {
              return Text("Secret Data: ${state.secretData}");
            } else {
              return const Text("Secret Data Error");
            }
          }),
        ],
      ),
    );
  }
}
