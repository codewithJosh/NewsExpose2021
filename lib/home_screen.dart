import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_expose_2k21/functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  _initAppBar() => AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: colorChineseBlack,
    toolbarHeight: 75.0,

    flexibleSpace: SafeArea(
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: linearAppBar,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: SvgPicture.string(
                createLogoUIButton,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ),

            initTitle1(),

            Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.string(
                createDrawerUIButton,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ),

          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _initAppBar(),

      body: Stack(
        children: <Widget>[

          Container(
            decoration: const BoxDecoration(
              color: colorChineseBlack,
            ),
          ),

          SafeArea(
            child: Stack(
              children: <Widget>[

                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.only(right: 25.0, bottom: 25.0),
                  child: SizedBox(
                    width: 75.0,
                    height: 75.0,
                    child: SvgPicture.string(
                      createCreateUpdateUIButton,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                )

              ],
            ),
          ),
        ],
      ),

    );
  }
}
