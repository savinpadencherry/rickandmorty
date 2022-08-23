// ignore_for_file: import_of_legacy_library_into_null_safe

library home_view;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:story/constants/constants.dart';
import 'package:story/core/blocs/rickandmorty/rickandmorty_bloc.dart';
import 'package:story/core/get.dart';
import 'package:story/core/repository/rickandmortyrepo.dart';
import 'package:story/core/services/navigator_service.dart';
import 'package:story/views/newsignup/newsignup_view.dart';
import 'package:story/views/something/something_view.dart';
import 'package:story/widgets/cardw.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'home_view_model.dart';

part 'home_mobile.dart';
part 'home_tablet.dart';
part 'home_desktop.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = HomeViewModel();
    return Builder(
      builder: (context) => ScreenTypeLayout(
        mobile: _HomeMobile(viewModel),
        desktop: _HomeDesktop(viewModel),
        tablet: _HomeTablet(viewModel),
      ),
    );
  }
}
