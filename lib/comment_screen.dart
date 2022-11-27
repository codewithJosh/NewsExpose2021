import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_expose_2k21/adapters/comment_adapter.dart';
import 'package:news_expose_2k21/functions.dart';
import 'package:news_expose_2k21/models/user_model.dart';

class CommentScreen extends StatefulWidget {
  final String updateId;

  const CommentScreen({Key? key, required this.updateId}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late final String _updateId = widget.updateId;
  final _commentContentController = TextEditingController();
  bool _isLoading = false;
  List<Comment> _comments = [];

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

  _onComment(final context, final userBio, final userImage, final userName,
      final commentContent) {
    onFocusLost(context);

    if (commentContent.isEmpty) {
      buildFlutterToast('Comment cannot be empty!', colorKUCrimson);
    } else {
      addComment() =>
          updatesRef.doc(_updateId).collection('Comments').doc().set({
            'comment_content': commentContent,
            'comment_timestamp': Timestamp.now(),
            'user_bio': userBio,
            'user_image': userImage,
            'user_name': userName,
          });

      addComment().then((value) {
        setState(() {
          _commentContentController.clear();
          _onLoadComments();
        });
      });
    }
  }

  _loadComments() => _isLoading
      ? buildCircularProgress()
      : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: _comments,
          ),
        );

  _onLoadComments() async {
    setState(() {
      _isLoading = true;
    });

    final querySnapshot =
        await updatesRef.doc(_updateId).collection('Comments').get();

    setState(() {
      _isLoading = false;
      _comments = querySnapshot.docs
          .map((documentSnapshot) => Comment.fromDocument(documentSnapshot))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _onLoadComments();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onFocusLost(context),
        child: Scaffold(
          appBar: _initAppBar(),
          body: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('res/images/img_background_2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    child: _loadComments(),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 55.0,
                    decoration: const BoxDecoration(
                      gradient: linearAppBar,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: FutureBuilder(
                            future: usersRef.doc(userId).get(),
                            builder: (context, dataSnapshot) {
                              if (!dataSnapshot.hasData) {
                                return buildCircularProgress();
                              }

                              final user = User.fromDocument(dataSnapshot.data);

                              final userBio = user.userBio!;
                              final userImage = user.userImage!;
                              final userName = user.userName!;

                              return ListTile(
                                leading: userImage.isNotEmpty
                                    ? CircleAvatar(
                                        radius: 20.0,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                userImage),
                                        backgroundColor: colorEerieBlack,
                                      )
                                    : CircleAvatar(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                            gradient: linearProfile,
                                          ),
                                        ),
                                      ),

                                title: TextField(
                                  controller: _commentContentController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1024),
                                  ],
                                  style: const TextStyle(color: colorFulvous),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Add a comment...',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Tahoma',
                                      fontSize: 15.0,
                                      color: colorBrightGray,
                                    ),
                                  ),
                                  textInputAction: TextInputAction.done,
                                ),

                                trailing: GestureDetector(
                                  onTap: () => _onComment(
                                      context,
                                      userBio,
                                      userImage,
                                      userName,
                                      _commentContentController.text.trim()),
                                  child: SvgPicture.string(
                                    createSendUIButton,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),

                                //
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
