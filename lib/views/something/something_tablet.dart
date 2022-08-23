part of something_view;

class _SomethingTablet extends StatelessWidget {
  final SomethingViewModel viewModel;

  _SomethingTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SomethingTablet')),
    );
  }
}