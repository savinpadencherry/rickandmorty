// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:logger/logger.dart';

import '../logger.dart';

class BaseService {
  late Logger log;

  BaseService({String? title}) {
    log = getLogger(
      title ?? runtimeType.toString(),
    );
  }
}
