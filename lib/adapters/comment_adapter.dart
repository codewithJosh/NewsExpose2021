import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_expose_2k21/functions.dart';

class Comment extends StatefulWidget {

  final String commentContent;
  final Timestamp commentTimestamp;
  final String userBio;
  final String userImage;
  final String userName;

  const Comment({Key? key, required this.commentContent, required this.commentTimestamp, required this.userBio, required this.userImage, required this.userName}) : super(key: key);

  factory Comment.fromDocument(final documentSnapshot) => Comment(
    commentContent: documentSnapshot['comment_content'],
    commentTimestamp: documentSnapshot['comment_timestamp'],
    userBio: documentSnapshot['user_bio'],
    userImage: documentSnapshot['user_image'],
    userName: documentSnapshot['user_name'],
  );

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {

  late final String _commentContent = widget.commentContent;
  late final Timestamp _commentTimestamp = widget.commentTimestamp;
  late final String _userBio = widget.userBio;
  late final String _userImage = widget.userImage;
  late final String _userName = widget.userName;

  @override
  Widget build(BuildContext context) => ListTile(

      leading: _userImage.isNotEmpty
          ? CircleAvatar(
        radius: 23.0,
        backgroundImage: CachedNetworkImageProvider(_userImage),
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

      title: Column(
        children: <Widget>[

          Container(
            alignment: Alignment.topLeft,
            child: initTitle2(_userBio, size: 17.0, fontWeight: FontWeight.bold, fontFamily: ''),
          ),

          Container(
            alignment: Alignment.topLeft,
            child: initTitle2('${initTimestamp(_commentTimestamp)} · $_userName'),
          ),

        ],
      ),

      subtitle: Container(
          alignment: Alignment.topLeft,
          child: initTitle2(_commentContent)
      ),
    );
}
