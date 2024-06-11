import 'package:finwise/src/app.dart';
import 'package:finwise/src/repository/database/database_repository_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/base/app_bloc_observer.dart';
import 'src/bloc/authentication/authentication_bloc.dart';
import 'src/bloc/database/database_bloc.dart';
import 'src/bloc/form/form_bloc.dart';
import 'src/repository/authentication/authentication_repository_impl.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  BindingBase.debugZoneErrorsAreFatal = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  Bloc.observer = AppBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
        AuthenticationBloc(AuthenticationRepositoryImpl())
          ..add(AuthenticationStarted()),
      ),
      BlocProvider(
        create: (context) => FormBloc(
            AuthenticationRepositoryImpl(), DatabaseRepositoryImpl()),
      ),
      BlocProvider(
        create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
      )
    ],
    child: MyApp(settingsController: settingsController,),
  ));
}