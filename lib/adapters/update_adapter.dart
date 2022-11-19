import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_expose_2k21/functions.dart';
import 'package:news_expose_2k21/models/user_model.dart';

class Update extends StatefulWidget {

  final String updateId;
  final String updateImage;
  final String updateContent;
  final Timestamp updateTimestamp;
  final String userId;
  final Map seen;

  const Update({Key? key, required this.updateId, required this.updateImage, required this.updateContent, required this.updateTimestamp, required this.userId, required this.seen}) : super(key: key);

  factory Update.fromDocument(final documentSnapshot) => Update(
      updateId: documentSnapshot['update_id'],
      updateImage: documentSnapshot['update_image'],
      updateContent: documentSnapshot['update_content'],
      updateTimestamp: documentSnapshot['update_timestamp'],
      userId: documentSnapshot['user_id'],
      seen: documentSnapshot['Seen'],
    );

  seenCount(final seen) {

    if (seen == null) {
      return 0;
    }
    else {
      int count = 0;
      seen.values.forEach((eachValue) {
        if (eachValue == true) {
          count++;
        }
      });
      return count;
    }
  }

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {

  late final String _updateImage = widget.updateImage;
  late final String _updateContent = widget.updateContent;
  late final Timestamp _updateTimestamp = widget.updateTimestamp;
  late final String _userId = widget.userId;
  late final Map _seen = widget.seen;
  late final int _seenCount = widget.seenCount(_seen);
  bool _isSeen = false;
  
  _initHead() => Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: FutureBuilder(
      future: usersRef.doc(_userId).get(),
      builder: (context, dataSnapshot) {

        if (!dataSnapshot.hasData) {
          return buildCircularProgress();
        }

        final user = User.fromDocument(dataSnapshot.data);
        return ListTile(
          leading: user.userImage!.isNotEmpty
              ? CircleAvatar(
            radius: 25.0,
            backgroundImage: CachedNetworkImageProvider(user.userImage!),
            backgroundColor: colorEerieBlack,
          )
              : CircleAvatar(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                gradient: linearProfile,
              ),
            ),
          ),

          title: initTitle2(user.userBio, size: 17.0, fontWeight: FontWeight.bold, fontFamily: ''),

          subtitle: initTitle2('${initUpdateTimestamp(_updateTimestamp)} · ${user.userName}'),
        );
      },
    ),
  );

  _initBody() => Image.network(_updateImage);

  _initFoot() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 18.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[

        Row(
          children: <Widget>[

            SizedBox(
              width: 30.0,
              height: 25.0,
              child: SvgPicture.string(
                _isSeen
                    ? createSeenUIButton
                    : createUnseenUIButton,
                allowDrawingOutsideViewBox: true,
              ),
            ),

            const SizedBox(width: 18.0,),

            initTitle2('$_seenCount', size: 17.0, color: _isSeen
                ? colorFulvous
                : Colors.white
            ),

          ],
        ),

        Row(
          children: <Widget>[

            SizedBox(
              width: 25.0,
              height: 25.0,
              child: SvgPicture.string(
                createCommentUIButton,
                allowDrawingOutsideViewBox: true,
              ),
            ),

            const SizedBox(width: 18.0,),

            initTitle2('0', size: 17.0),

          ],
        ),


      ],
    ),
  );

  @override
  Widget build(BuildContext context) {

    _isSeen = (_seen[userId] == true);

    return Container(
      margin: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: colorEerieBlack,
      ),
      child: Column(
        children: <Widget>[

          _initHead(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: <Widget>[

                _updateContent.isNotEmpty
                    ? Container(
                    alignment: Alignment.topLeft,
                    child: initTitle2(_updateContent))
                    : Container(),
                const SizedBox(height: 10.0,),

                _initBody(),

                _initFoot(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
