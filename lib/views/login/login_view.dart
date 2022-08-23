// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

library login_widget;

import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:story/core/get.dart';
import 'package:story/core/services/navigator_service.dart';
import 'package:story/views/newsignup/newsignup_view.dart';
import 'package:story/views/signup/signup_view.dart';
import 'package:validators/validators.dart';

part 'login_mobile.dart';
part 'login_tablet.dart';
part 'login_desktop.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _LoginMobile(),
      desktop: _LoginDesktop(),
      tablet: _LoginTablet(),
    );
  }
}
