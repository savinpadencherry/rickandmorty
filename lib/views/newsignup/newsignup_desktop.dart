// ignore_for_file: prefer_const_constructors

part of newsignup_view;

class _NewsignupDesktop extends StatelessWidget {
  final NewsignupViewModel viewModel;

  const _NewsignupDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('NewsignupDesktop')),
    );
  }
}
