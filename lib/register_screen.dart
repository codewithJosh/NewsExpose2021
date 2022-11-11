import 'package:flutter/material.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:news_expose_2k21/functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[

            createPrimary(),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[

                    const SizedBox(height: 20.0,),

                    createSvgLogo(),

                    const SizedBox(height: 76.0,),

                    SizedBox(
                      height: 505,
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

                                createTitle1('Sign Up'),

                                TextFormField(
                                  style: const TextStyle(color: colorFulvous),
                                  decoration: createInputDecoration('Username'),
                                ),
                                const SizedBox(height: 20.0,),

                                TextFormField(
                                  style: const TextStyle(color: colorFulvous),
                                  decoration: createInputDecoration('Email'),
                                ),
                                const SizedBox(height: 20.0,),

                                TextFormField(
                                  style: const TextStyle(color: colorFulvous),
                                  decoration: createInputDecoration('Password'),
                                  obscureText: true,
                                ),
                                const SizedBox(height: 20.0,),

                                TextFormField(
                                  style: const TextStyle(color: colorFulvous),
                                  decoration: createInputDecoration('Re-Enter Password'),
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
                                            label: createLabel('SIGN UP'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                createTextButton(context, 'Already have an account?', 'Sign In', 225.0),

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
