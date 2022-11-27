import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_expose_2k21/functions.dart';
import 'package:news_expose_2k21/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email, _password;

  final _formKey = GlobalKey<FormState>();

  _onLogin(final context) async {
    onFocusLost(context);
    await initProgressDialog(context, 'Logging in');

    if (_formKey.currentState!.validate()) {
      buildProgressDialog.show();
      firebaseAuth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        buildProgressDialog.hide();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        buildFlutterToast(
            'Welcome, You\'ve Successfully Login!', colorElectricGreen,
            isLong: true);
      }).catchError((e) {
        buildProgressDialog.hide();
        if (e.toString().contains('auth/user-not-found')) {
          buildFlutterToast('User Doesn\'t Exist!', colorKUCrimson);
        } else if (e.toString().contains('auth/network-request-failed')) {
          buildFlutterToast('No Internet Connection!', colorKUCrimson);
        } else if (e.toString().contains('auth/wrong-password')) {
          buildFlutterToast('Incorrect Password!', colorKUCrimson);
        } else {
          buildFlutterToast(
              'Please Contact Your Service Provider', colorKUCrimson);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => onFocusLost(context),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              initBackground(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20.0,
                        ),
                        initLogo(),
                        const SizedBox(
                          height: 88.0,
                        ),
                        SizedBox(
                          height: 375.0,
                          child: Stack(
                            children: <Widget>[
                              BlendMask(
                                blendMode: BlendMode.softLight,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: colorChineseBlack,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    initTitle('Sign In'),
                                    Focus(
                                      onFocusChange: (_) =>
                                          onFocusChange(_formKey),
                                      child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[a-z_.0-9@]')),
                                          LengthLimitingTextInputFormatter(25),
                                        ],
                                        style: const TextStyle(
                                            color: colorFulvous),
                                        decoration:
                                            initInputDecoration('Email'),
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) =>
                                            FocusScope.of(context).nextFocus(),
                                        validator: (input) {
                                          if (input!.isEmpty) {
                                            return 'Email is required!';
                                          } else if (!input
                                              .endsWith('@ne.xpose')) {
                                            return 'Must end with @ne.xpose';
                                          } else if (input.length < 10) {
                                            return 'Provide a valid Email Address';
                                          }
                                          return null;
                                        },
                                        onSaved: (input) => _email =
                                            input!.trim().toLowerCase(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Focus(
                                      onFocusChange: (_) =>
                                          onFocusChange(_formKey),
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: colorFulvous),
                                        decoration:
                                            initInputDecoration('Password'),
                                        obscureText: true,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (_) =>
                                            FocusScope.of(context).nextFocus(),
                                        validator: (input) {
                                          if (input!.length < 6) {
                                            return 'Must be at least 6 characters';
                                          }
                                          return null;
                                        },
                                        onSaved: (input) =>
                                            _password = input!.trim(),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      height: 43.0,
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22.0),
                                              gradient: linearButton,
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: width,
                                              child:
                                                  FloatingActionButton.extended(
                                                onPressed: () =>
                                                    _onLogin(context),
                                                heroTag: null,
                                                splashColor: colorKUCrimson,
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0.0,
                                                label: initLabel('SIGN IN'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    initTextButton(
                                        context,
                                        'Don\'t have an account yet?',
                                        'Sign Up',
                                        225.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
