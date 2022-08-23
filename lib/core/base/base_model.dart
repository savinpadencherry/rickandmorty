// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';

abstract class BaseModel implements Equatable {
  Map<String, Object> toMap();
}
