import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_expose_2k21/create_update_screen.dart';
import 'package:news_expose_2k21/functions.dart';

import 'models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late File _uri;

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

  _buildGetImage(final context) => showModalBottomSheet(
      context: context,
      builder: (context) => Container(
            decoration: const BoxDecoration(
              gradient: linearAppBar,
            ),
            height: 120,
            child: Column(
              children: <Widget>[
                _initListTile(context, 'Capture Image with Camera'),
                _initListTile(context, 'Select Image from Gallery')
              ],
            ),
          ));

  _initListTile(final context, final text) => ListTile(
        leading: SizedBox(
          width: 30.0,
          height: 25.0,
          child: SvgPicture.string(
            text.contains('Capture Image with Camera')
                ? createCameraUIButton
                : createGalleryUIButton,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        onTap: () async {
          final image = await ImagePicker().pickImage(
              source: text.contains('Capture Image with Camera')
                  ? ImageSource.camera
                  : ImageSource.gallery);
          Navigator.of(context).pop();
          setState(() {
            _uri = File(image!.path);
          });
          _onCreateUpdate(context);
        },
      );

  _onCreateUpdate(final context) {
    final route =
        MaterialPageRoute(builder: (context) => CreateUpdateScreen(uri: _uri));
    Navigator.of(context).push(route);
  }

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
                FutureBuilder(
                    future: users.doc(userId).get(),
                    builder: (context, dataSnapshot) {
                      if (!dataSnapshot.hasData) {
                        return buildCircularProgress();
                      }

                      final user = User.fromDocument(dataSnapshot.data);

                      return user.userIsAdmin == true
                          ? Container(
                              alignment: Alignment.bottomRight,
                              padding: const EdgeInsets.only(
                                  right: 25.0, bottom: 25.0),
                              child: GestureDetector(
                                onTap: () => _buildGetImage(context),
                                child: SizedBox(
                                  width: 75.0,
                                  height: 75.0,
                                  child: SvgPicture.string(
                                    createCreateUpdateUIButton,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            )
                          : Container();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
