part of something_view;

class _SomethingDesktop extends StatelessWidget {
  final SomethingViewModel viewModel;

  _SomethingDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SomethingDesktop')),
    );
  }
}