import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:story/core/repository/authrepository.dart';
import 'package:story/core/services/navigator_service.dart';

GetIt get app => GetIt.instance;
void initializeGetIt() {
  log("Initializing GetIt");
  app.registerLazySingleton(() => NavigatorService());
  app.registerLazySingleton(() => AuthRepository());
}
