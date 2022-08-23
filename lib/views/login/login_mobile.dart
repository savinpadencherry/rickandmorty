// ignore_for_file: unused_element

part of login_widget;

class _LoginMobile extends StatefulWidget {
  @override
  State<_LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<_LoginMobile>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  late Animation<Size> _heightanimation;

  late Animation<Offset> _slideAnimation;

  String? email, password;

  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  late final AnimationController _controller;

  late Animation<Color?> _colorAnimation;

  bool hasShownDialog = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _heightanimation =
        Tween<Size>(begin: const Size(100, 100), end: const Size(300, 500))
            .animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    )..addListener(() {
            setState(() {});
          });
    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1.5, 0), end: const Offset(0, 0))
            .animate(
                CurvedAnimation(parent: _controller, curve: Curves.bounceInOut))
          ..addListener(() {
            setState(() {});
          });
    _colorAnimation = ColorTween(
            begin: Colors.grey,
            end: CupertinoColors.secondarySystemGroupedBackground)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
    _heightanimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _controller.forward();
      }
    });
    _slideAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.stop();
      }
    });
    _colorAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _showErrorLoginDialog(String? error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text('Login Error'),
        ),
        content: Text(error!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  _showErrorOnLogin(String? httpException) {
    var errorMessage = 'Authentication Error';
    if (httpException.toString().contains('EMAIL_EXISTS')) {
      //change keywords according to databasse
      errorMessage = 'This Email address is already in use';
    } else if (httpException.toString().contains('INVALID_EMAIL')) {
      //change keywords according to databasse
      errorMessage = 'Please try again with a valid Email address';
    } else if (httpException.toString().contains('WEAK_PASSWORD')) {
      //change keywords according to databasse
      errorMessage = 'Weak password';
    } else if (httpException.toString().contains('EMAIL_NOT_FOUND')) {
      errorMessage = 'Email Not Found';
    } else if (httpException.toString().contains('INVALID_PASSWORD')) {
      errorMessage = 'Wrong Password';
    }
    _showErrorLoginDialog(errorMessage);
  }

  void submit() {
    final form = _signInFormKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    // context.read<AuthBloc>().add(
    //       SignInEvent(email: email!, password: password!),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeIn,
          height: //state.authStatus == Constants.authLoading
              // ?
              550,
          // : _heightanimation.value.height,
          width: //state.authStatus == Constants.authLoading
              //?
              350,
          // : _heightanimation.value.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: // state.authStatus == Constants.authLoading
                  //?
                  Colors.white
              // : _colorAnimation.value
              ),
          child: Form(
            key: _signInFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          filled: true,
                          labelText: 'Email',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Must Contain a email';
                          }
                          if (!isEmail(value.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          email = value;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        autocorrect: false,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          filled: true,
                          labelText: 'password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Password cant be null";
                          }
                          if (value.trim().length < 6) {
                            return "password must be atleast 6 characters";
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          password = value;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/ForgotPassword');
                          }, //forgot password,
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceInOut,
                    height: // state.authStatus == Constants.authLoading
                        //?
                        55,
                    // : 45,
                    width: //state.authStatus == Constants.authLoading
                        // ?
                        160,
                    // : 150,
                    child: ElevatedButton(
                      onPressed: submit,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        backgroundColor: // state.authStatus ==
                            //  Constants.authLoading
                            // ?
                            MaterialStateProperty.all(Colors.green),
                        // : MaterialStateProperty.all(
                        //         Colors.orange),
                      ),
                      child: //state.authStatus == Constants.authLoading
                          // ?
                          //     const Text(
                          //   'Logging in',
                          //   style: TextStyle(color: Colors.white),
                          // )
                          //  :
                          const Text(
                        'Log in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () => app<NavigatorService>()
                        .buildAndPush(const NewsignupView()),
                    child: RichText(
                      text: TextSpan(
                        text: 'Dont Have an account? ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
