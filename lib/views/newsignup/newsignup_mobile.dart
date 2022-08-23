part of newsignup_view;

class _NewsignupMobile extends StatefulWidget {
  final NewsignupViewModel viewModel;

  const _NewsignupMobile(this.viewModel);

  @override
  State<_NewsignupMobile> createState() => _NewsignupMobileState();
}

class _NewsignupMobileState extends State<_NewsignupMobile>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late AnimationController _textFieldsController;
  late Animation<Offset> _slideAnimation;
  Animation<Size>? _heightAnimation;
  Animation<Color?>? colorAnimation;
  String? phoneNumber, password;
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
      end: const Size(300, 300),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn)
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

  submit() {
    final form = _signUpFormKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    context.read<AuthBloc>().add(
          AuthPhoneCode(phoneNumber: phoneNumber!),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        dev.log('$state', name: "checking for the state in newSignUp View");
        if (state.authStatus == Constants.authSuccessSendingCode) {
          app<NavigatorService>().buildAndPush(
            const VerificationpageView(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeIn,
              height: state.authStatus == Constants.authLoading
                  ? 350
                  : _heightAnimation?.value.height,
              width: state.authStatus == Constants.authLoading
                  ? 350
                  : _heightAnimation?.value.width,
              decoration: BoxDecoration(
                color: state.authStatus == Constants.authLoading
                    ? Colors.white
                    : colorAnimation?.value,
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              filled: true,
                              labelText: 'Phone Number',
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Must Contain a PhoneNumber';
                              }
                              if (value.length < 12 || value.length > 20) {
                                return 'Length of phone number invalid';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              phoneNumber = value;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.bounceInOut,
                        height: // state.sendingCodeStatus ==
                            // Constants.authLoading
                            // ?
                            55,
                        // : 45,
                        width: // state.sendingCodeStatus ==
                            //  Constants.authLoading
                            //  ?
                            160,
                        //   : 150,
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
                                // MaterialStateProperty.all(Colors.green)
                                // :
                                MaterialStateProperty.all(Colors.orange),
                          ),
                          child: // state.sendingCodeStatus ==
                              //  Constants.authSuccessSendingCode
                              // ?
                              // const Text(
                              //     'Sending Code..',
                              //     style: TextStyle(color: Colors.white),
                              //   )
                              //  :
                              const Text(
                            'Send Code',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => app<NavigatorService>().buildAndPush(
                          const LoginView(),
                        ),
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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
      },
    );
  }
}
