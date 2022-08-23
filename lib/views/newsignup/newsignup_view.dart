library newsignup_view;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:story/core/blocs/auth/auth_bloc.dart';
import 'package:story/core/get.dart';
import 'package:story/core/services/navigator_service.dart';
import 'package:story/views/login/login_view.dart';
import 'package:story/views/verificationpage/verificationpage_view.dart';
import 'dart:developer' as dev;
import '../../constants/constants.dart';
import 'newsignup_view_model.dart';

part 'newsignup_mobile.dart';
part 'newsignup_tablet.dart';
part 'newsignup_desktop.dart';

class NewsignupView extends StatelessWidget {
  const NewsignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsignupViewModel viewModel = NewsignupViewModel();
    return Builder(builder: (context) {
      return ScreenTypeLayout(
        mobile: _NewsignupMobile(viewModel),
        desktop: _NewsignupDesktop(viewModel),
        tablet: _NewsignupTablet(viewModel),
      );
    });
  }
}
