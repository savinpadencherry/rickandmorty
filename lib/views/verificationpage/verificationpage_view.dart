library verificationpage_view;

import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:story/constants/constants.dart';
import 'package:story/core/blocs/auth/auth_bloc.dart';
import 'package:story/core/get.dart';
import 'package:story/core/repository/authrepository.dart';
import 'package:story/core/services/navigator_service.dart';
import 'package:story/views/home/home_view.dart';
import 'package:story/views/login/login_view.dart';
import 'verificationpage_view_model.dart';
import 'dart:developer' as dev;

part 'verificationpage_mobile.dart';
part 'verificationpage_desktop.dart';

class VerificationpageView extends StatelessWidget {
  const VerificationpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VerificationpageViewModel viewModel = VerificationpageViewModel();
    return Builder(builder: (context) {
      return ScreenTypeLayout(
        mobile: _VerificationpageMobile(viewModel),
        desktop: _VerificationpageDesktop(viewModel),
      );
    });
  }
}
