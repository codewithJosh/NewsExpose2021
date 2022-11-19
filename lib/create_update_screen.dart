import 'dart:io';

import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_expose_2k21/functions.dart';
import 'package:random_string/random_string.dart';

class CreateUpdateScreen extends StatefulWidget {
  final File uri;

  const CreateUpdateScreen({Key? key, required this.uri}) : super(key: key);

  @override
  State<CreateUpdateScreen> createState() => _CreateUpdateScreenState();
}

class _CreateUpdateScreenState extends State<CreateUpdateScreen> {
  File? _uri;
  late String _content;
  bool _isUploading = false;
  int _pendingRequests = 0;

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
                child: GestureDetector(
                  onTap: () => _onCreateUpdate(context),
                  child: SizedBox(
                    height: 20.0,
                    width: 18.0,
                    child: SvgPicture.string(
                      createUploadUIButton,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

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
        },
      );

  _onCreateUpdate(final context) async {
    if (_uri != null) {
      setState(() {
        _isUploading = true;
        _pendingRequests++;
      });

      buildFlutterToast('Currently Uploading Please Wait', colorFulvous,
          isLong: true);

      if (_pendingRequests == 1) {
        final ref = firebaseStorage
            .ref()
            .child('Updates')
            .child(randomAlphaNumeric(9) + extension(_uri!.path));

        final uploadTask = ref.putFile(_uri!);

        final updateImage =
            await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

        if (updateImage.isNotEmpty) {
          final updateId = updates.doc().id;

          addUpdates() async {
            final documentSnapshot = await updates.doc(updateId).get();

            if (!documentSnapshot.exists) {
              updates.doc(updateId).set({
                'update_id': updateId,
                'update_image': updateImage,
                'update_content': _content,
                'update_timestamp': Timestamp.now(),
                'user_id': userId,
                'Seen': {},
              });
            }
          }

          addUpdates().then((value) => Navigator.pop(context));
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _uri = widget.uri;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: _initAppBar(context),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: colorChineseBlack,
              ),
            ),
            _isUploading
                ? buildCircularProgress()
                : Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      height: height / 2,
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
                                  child: GestureDetector(
                                    onTap: () => _buildGetImage(context),
                                    child: SizedBox(
                                      height: height,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.file(
                                          _uri!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: TextField(
                                      minLines: 1,
                                      maxLines: 5,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1024),
                                      ],
                                      style:
                                          const TextStyle(color: colorFulvous),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Subject',
                                        hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontStyle: FontStyle.italic,
                                        ),
                                        filled: true,
                                        fillColor:
                                            colorChineseBlack.withOpacity(0.75),
                                        contentPadding:
                                            const EdgeInsets.all(8.0),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: colorFulvous),
                                        ),
                                      ),
                                      onChanged: (input) =>
                                          _content = input.trim(),
                                      textInputAction: TextInputAction.newline,
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
      ),
    );
  }
}
