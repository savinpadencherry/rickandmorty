// ignore_for_file: prefer_const_constructors

part of newsignup_view;

class _NewsignupTablet extends StatelessWidget {
  final NewsignupViewModel viewModel;

  const _NewsignupTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('NewsignupTablet')),
    );
  }
}
