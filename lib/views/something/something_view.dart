library something_view;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:story/core/repository/rickandmortyrepo.dart';
import 'package:story/core/services/navigator_service.dart';
import 'package:story/widgets/cardw.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../core/get.dart';
import 'something_view_model.dart';

part 'something_mobile.dart';
part 'something_tablet.dart';
part 'something_desktop.dart';

class SomethingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SomethingViewModel viewModel = SomethingViewModel();
    return Builder(builder: (context) {
      return ScreenTypeLayout(
        //
        mobile: _SomethingMobile(viewModel),
        desktop: _SomethingDesktop(viewModel),
        tablet: _SomethingTablet(viewModel),
      );
    });
  }
}
