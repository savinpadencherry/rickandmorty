// ignore_for_file: use_key_in_widget_constructors

library signup_view;

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:story/core/get.dart';
import 'package:story/core/services/navigator_service.dart';
import 'package:story/views/login/login_view.dart';
import 'package:validators/validators.dart';
import 'signup_view_model.dart';

part 'signup_mobile.dart';
part 'signup_tablet.dart';
part 'signup_desktop.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignupViewModel viewModel = SignupViewModel();
    return Builder(
        builder: (context) => ScreenTypeLayout(
              mobile: _SignupMobile(viewModel),
              desktop: _SignupDesktop(viewModel),
              tablet: _SignupTablet(viewModel),
            ));
  }
}
