import 'package:flutter/material.dart';
import 'package:news_expose_2k21/functions.dart';

class MainScreen extends StatelessWidget
{
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Stack(
        children: <Widget>[
          createStart(context),
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 50.0,
                    decoration: const BoxDecoration(
                      gradient: linearButton,
                    ),
                    child: const Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontFamily: 'Calibri',
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: colorChineseBlack,
                    ),
                    child: const Center(
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          fontFamily: 'Calibri',
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}