// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_element

part of signup_view;

class _SignupMobile extends StatefulWidget {
  final SignupViewModel viewModel;

  const _SignupMobile(this.viewModel);

  @override
  State<_SignupMobile> createState() => _SignupMobileState();
}

class _SignupMobileState extends State<_SignupMobile>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
    late AnimationController _animationController;
    late AnimationController _textFieldsController;
    final TextEditingController _passwordController = TextEditingController();
    late Animation<Offset> _slideAnimation;
    Animation<Size>? _heightAnimation;
    Animation<Color?>? colorAnimation;
    String? email, password;
    bool hasShownSignUpDialog = false;
    bool hasShownSnackbar = false;
    @override
    void initState() {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      );
      _textFieldsController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      _slideAnimation =
          Tween<Offset>(begin: const Offset(-1.5, 0), end: const Offset(0, 0))
              .animate(
        CurvedAnimation(
            parent: _textFieldsController, curve: Curves.linearToEaseOut),
      )..addListener(() {
              setState(() {});
            });
      _heightAnimation = Tween<Size>(
        begin: const Size(100, 100),
        end: const Size(300, 500),
      ).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.fastOutSlowIn)
          ..addListener(() {
            setState(() {});
          }),
      );
      colorAnimation = ColorTween(begin: Colors.grey, end: Colors.white)
          .animate(_animationController)
        ..addListener(() {
          setState(() {});
        });
      _animationController.forward();
      _heightAnimation?.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.stop();
          _textFieldsController.forward();
        }
      });
      colorAnimation?.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.stop();
        }
      });
      _slideAnimation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _textFieldsController.stop();
        }
      });
      super.initState();
    }

    @override
    void dispose() {
      _animationController.dispose();
      _textFieldsController.dispose();
      super.dispose();
    }

    void _showErrorSignUpDialog({String? message}) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(
            child: Text(
              'Authentication error',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(message!),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }

    _showErrorOnSignUp(String? httpException) {
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
      _showErrorSignUpDialog(message: errorMessage);
    }

    void submit() {
      final form = _signUpFormKey.currentState;
      if (form == null || !form.validate()) return;
      form.save();
      // dev.log('email = $email , password  = $password',
      //     name: 'Sign up Submit function');
      // context.read<AuthBloc>().add(
      //       SignUpEvent(email: email!, password: password!),
      //     );
    }

    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeIn,
          height: //state.authStatus == Constants.authLoading
              // ?
              550,
          // : _heightAnimation?.value.height,
          width: //state.authStatus == Constants.authLoading
              // ?
              350,
          // : _heightAnimation?.value.width,
          decoration: BoxDecoration(
            color: // state.authStatus == Constants.authLoading
                // ?
                Colors.grey,
            // : colorAnimation?.value,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Form(
            key: _signUpFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
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
                        if (value.contains('@gmail.com') ||
                            value.contains('@protonmail.com') ||
                            value.contains('@outlook.com') ||
                            value.contains('@hotmail.com') ||
                            value.contains('@yahoo.com') ||
                            value.contains('@zoho.com') ||
                            value.contains('@aol.com') ||
                            value.contains('@aim.com') ||
                            value.contains('@gmx.com') ||
                            value.contains('@icloud.com') ||
                            value.contains('@gmx.us') ||
                            value.contains('@tutanota.com') ||
                            value.contains('@tutamail.com')) {
                          return null;
                        } else {
                          return 'Please try with an other email provider';
                        }
                      },
                      onSaved: (String? value) {
                        email = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
                    child: TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        filled: true,
                        labelText: 'Confirm password',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      ),
                      validator: (String? value) {
                        if (_passwordController.text != value) {
                          return "Passwords dont match";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.bounceInOut,
                    height: // state.authStatus == Constants.authLoading
                        //  ?
                        55,
                    //  : 45,
                    width: // state.authStatus == Constants.authLoading
                        // ?
                        160,
                    //  : 150,
                    child: ElevatedButton(
                      onPressed: submit,
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          backgroundColor: // state.authStatus ==
                              // Constants.authLoading
                              // ?
                              MaterialStateProperty.all(Colors.green)
                          //: MaterialStateProperty.all(
                          //    Colors.orange),
                          ),
                      child: //state.authStatus == Constants.authLoading
                          // ? const Text(
                          //     'Loading',
                          //     style: TextStyle(color: Colors.white),
                          //   )
                          //  :
                          const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () =>
                        app<NavigatorService>().buildAndPush(LoginView()),
                    child: RichText(
                      text: TextSpan(
                        text: 'Have an account Already? ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: 'Log In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
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
