import 'dart:io';

import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_expose_2k21/functions.dart';

class CreateUpdateScreen extends StatefulWidget {
  final File uri;

  const CreateUpdateScreen({Key? key, required this.uri}) : super(key: key);

  @override
  State<CreateUpdateScreen> createState() => _CreateUpdateScreenState();
}

class _CreateUpdateScreenState extends State<CreateUpdateScreen> {

  late File _uri;

  _initAppBar(final context) {

    final width = MediaQuery.of(context).size.width;

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: colorChineseBlack,
      toolbarHeight: 48.0,

      flexibleSpace: SafeArea(
        child: Container(
          width: width,
          decoration: const BoxDecoration(
            gradient: linearAppBar,
          ),
          child: Stack(
            children: <Widget>[

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    initTitle1(),

                  ],
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 20.0),
                child: SizedBox(
                  height: 20.0,
                  width: 18.0,
                  child: SvgPicture.string(
                    createUploadUIButton,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _uri = widget.uri;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(

      appBar: _initAppBar(context),

      body: Stack(
        children: <Widget>[

          Container(
            decoration: const BoxDecoration(
              color: colorChineseBlack,
            ),
          ),

          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              height: height/2,
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
                      children: <Widget>[

                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: height,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                _uri,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15,),

                        Expanded(
                          flex: 1,
                          child: Center(
                            child: TextField(
                              minLines: 1,
                              maxLines: 5,
                              style: const TextStyle(color: colorFulvous),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Subject',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontStyle: FontStyle.italic,
                                ),
                                filled: true,
                                fillColor: colorChineseBlack.withOpacity(0.75),
                                contentPadding: const EdgeInsets.all(8.0),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: colorFulvous),
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
          ),
        ],
      ),
    );
  }
}
