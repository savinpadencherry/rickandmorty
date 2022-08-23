part of verificationpage_view;

class _VerificationpageDesktop extends StatelessWidget {
  final VerificationpageViewModel viewModel;

  _VerificationpageDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('VerificationpageDesktop')),
    );
  }
}