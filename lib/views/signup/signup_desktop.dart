// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

part of signup_view;

class _SignupDesktop extends StatelessWidget {
  final SignupViewModel viewModel;

  _SignupDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SignupDesktop')),
    );
  }
}
