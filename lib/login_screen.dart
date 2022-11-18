import 'package:adobe_xd/blend_mask.dart';
import 'package:flutter/material.dart';
import 'package:news_expose_2k21/functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[

            initBackground(),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[


                    const SizedBox(height: 20.0,),

                    initLogo(),

                    const SizedBox(height: 88.0,),

                    SizedBox(
                      height: 353.0,
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

                                TextFormField(
                                  style: const TextStyle(color: colorFulvous),
                                  decoration: initInputDecoration('Email'),
                                ),
                                const SizedBox(height: 20.0,),

                                TextFormField(
                                  style: const TextStyle(color: colorFulvous),
                                  decoration: initInputDecoration('Password'),
                                  obscureText: true,
                                ),

                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                                  height: 43.0,
                                  child: Stack(
                                    children: <Widget>[

                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(22.0),
                                          gradient: linearButton,
                                        ),
                                      ),

                                      Center(
                                        child: SizedBox(
                                          width: width,
                                          child: FloatingActionButton.extended(
                                            onPressed: () {},
                                            heroTag: null,
                                            splashColor: colorKUCrimson,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0.0,
                                            label: initLabel('SIGN IN'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                initTextButton(context, 'Don\'t have an account yet?', 'Sign Up', 225.0),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20.0,),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
