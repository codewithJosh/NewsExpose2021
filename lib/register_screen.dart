import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_expose_2k21/functions.dart';
import 'package:news_expose_2k21/login_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String _userName, _email, _password, _rePassword;

  final _formKey = GlobalKey<FormState>();

  _onRegister(final context) async {
    onFocusLost(context);
    await initProgressDialog(context, 'Signing up');

    if (_formKey.currentState!.validate() && _rePassword.isNotEmpty) {
      buildProgressDialog.show();
      firebaseAuth
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        final userId = user.user!.uid;

        addUser() async {
          final documentSnapshot = await usersRef.doc(userId).get();
          final packageInfo = await PackageInfo.fromPlatform();

          if (!documentSnapshot.exists) {
            const userBio = '';
            const userImage =
                'https://firebasestorage.googleapis.com/v0/b/news-expose-2k21.appspot.com/o/Res_20221117%2Fdefault_user_image.png?alt=media&token=8117d47e-2021-4ef8-81c0-7ce0c0c13b3e';
            const userIsAdmin = false;
            final buildNumber = packageInfo.buildNumber;

            return usersRef.doc(userId).set({
              'build_number': buildNumber,
              'user_bio': userBio,
              'user_email': _email,
              'user_id': userId,
              'user_image': userImage,
              'user_is_admin': userIsAdmin,
              'user_name': _userName,
            });
          }
        }

        addUser().then((_) {
          buildProgressDialog.hide();
          buildFlutterToast('You\'re Successfully Added!', colorElectricGreen,
              isLong: true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (final context) => const LoginScreen()));
        });
      }).catchError((e) {
        buildProgressDialog.hide();
        if (e.toString().contains('auth/email-already-in-use')) {
          buildFlutterToast('Email is Already Exist!', colorKUCrimson);
        } else if (e.toString().contains('auth/network-request-failed')) {
          buildFlutterToast('Internet Connection Lost!', colorKUCrimson);
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
                          height: 76.0,
                        ),
                        SizedBox(
                          height: 550,
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
                                    initTitle('Sign Up'),
                                    Focus(
                                      onFocusChange: (_) =>
                                          onFocusChange(_formKey),
                                      child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[a-z_.0-9@]')),
                                          LengthLimitingTextInputFormatter(16),
                                        ],
                                        style: const TextStyle(
                                            color: colorFulvous),
                                        decoration:
                                            initInputDecoration('Username'),
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) =>
                                            FocusScope.of(context).nextFocus(),
                                        validator: (input) {
                                          if (input!.isEmpty) {
                                            return 'Username is required!';
                                          } else if (!input
                                              .startsWith('@ne.')) {
                                            return 'Must starts with @ne.';
                                          } else if (input.length < 5) {
                                            return 'Provide a valid Username';
                                          }
                                          return null;
                                        },
                                        onSaved: (input) => _userName =
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
                                        textInputAction: TextInputAction.next,
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
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Focus(
                                      onFocusChange: (_) =>
                                          onFocusChange(_formKey),
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: colorFulvous),
                                        decoration: initInputDecoration(
                                            'Re-Enter Password'),
                                        obscureText: true,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (_) =>
                                            FocusScope.of(context).unfocus(),
                                        validator: (input) {
                                          if (_password != _rePassword) {
                                            return 'Password doesn\'t match';
                                          }
                                          return null;
                                        },
                                        onSaved: (input) =>
                                            _rePassword = input!.trim(),
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
                                                    _onRegister(context),
                                                heroTag: null,
                                                splashColor: colorKUCrimson,
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0.0,
                                                label: initLabel('SIGN UP'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    initTextButton(
                                        context,
                                        'Already have an account?',
                                        'Sign In',
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
