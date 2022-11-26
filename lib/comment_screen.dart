import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_expose_2k21/functions.dart';

class CommentScreen extends StatefulWidget {
  final String updateId;

  const CommentScreen({Key? key, required this.updateId}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  _initAppBar() => AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: colorChineseBlack,
    toolbarHeight: 55.0,

    flexibleSpace: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: linearAppBar,
        ),
        child: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 60.0),
          child: initTitle2('Comments', size: 23.0),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: _initAppBar(),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('res/images/img_background_2.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
