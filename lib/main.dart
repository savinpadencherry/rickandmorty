// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story/core/blocs/auth/auth_bloc.dart';
import 'package:story/core/blocs/rickandmorty/rickandmorty_bloc.dart';
import 'package:story/core/repository/authrepository.dart';
import 'package:story/core/repository/rickandmortyrepo.dart';
import 'package:story/views/login/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:story/views/newsignup/newsignup_view.dart';
import 'core/get.dart';
import 'firebase_options.dart';

import 'core/locator.dart';
import 'core/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'views/home/home_view.dart';
import 'dart:developer' as dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<RickAndMortyRepository>(
          create: (context) => RickAndMortyRepository(),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
            BlocProvider<RickandmortyBloc>(
              create: (context) => RickandmortyBloc(
                rickAndMortyRepository: context.read<RickAndMortyRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            navigatorKey: locator<NavigatorService>().navigatorKey,
            home: NewsignupView(),
          )),
    );
  }
}
