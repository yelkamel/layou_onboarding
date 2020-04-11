import 'package:auth/model/login.dart';
import 'package:auth/tunnel/bloc/entrance_bloc.dart';
import 'package:auth/view/screen/home.dart';
import 'package:auth/view/screen/login.dart';
import 'package:auth/view/screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/entrance_bloc.dart';
import 'bloc/entrance_state.dart';
import 'bloc/entrance_event.dart';

class Entrance extends StatelessWidget {
  @override
  Widget build(BuildContext contect) {
    return BlocProvider(
      create: (context) => EntranceBloc()..add(AppStarted()),
      child: Scaffold(
        body: BlocBuilder<EntranceBloc, EntranceState>(
          builder: (context, state) {
            if (state is LoginStep) {
              return ChangeNotifierProvider<LoginModel>(
                create: (_) => LoginModel(onSuccess: (String email) {
                  print("email $email");
                  BlocProvider.of<EntranceBloc>(context).add(
                    LoggedIn(email: email),
                  );
                }),
                child: LoginScreen(),
              );
            }
            if (state is EntranceEnd) {
              return HomeScreen(email: state.email);
            }
            return Splashscreen();
          },
        ),
      ),
    );
  }
}