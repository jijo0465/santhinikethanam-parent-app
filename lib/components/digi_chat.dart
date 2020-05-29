import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parent_app/models/teacher.dart';
import 'package:uuid/uuid.dart';

class DigiChat extends StatefulWidget {
  final Teacher teacher;
  final int studentId;

  DigiChat({this.teacher, this.studentId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<DigiChat> {
  ChatUser user;

  @override
  void initState() {
    print(widget.teacher.name);
    user = ChatUser(
      uid: widget.teacher.id.toString(),
      name: widget.teacher.name,
      avatar: widget.teacher.photoUrl,
    );
    // user.uid = "";
    super.initState();
  }

  void onSend(ChatMessage message) {
    var documentReference = Firestore.instance
        .collection('messages_${widget.teacher.id}_${widget.studentId}')
        .document(DateTime.now().millisecondsSinceEpoch.toString());

    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        message.toJson(),
      );
    });
  }

  void uploadFile() async {
    File result = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxHeight: 400,
      maxWidth: 400,
    );

    if (result != null) {
      String id = Uuid().v4().toString();

      final StorageReference storageRef =
          FirebaseStorage.instance.ref().child("chat_images/$id.jpg");

      StorageUploadTask uploadTask = storageRef.putFile(
        result,
        StorageMetadata(
          contentType: 'image/jpg',
        ),
      );
      StorageTaskSnapshot download = await uploadTask.onComplete;

      String url = await download.ref.getDownloadURL();

      ChatMessage message = ChatMessage(text: "", user: user, image: url);

      var documentReference = Firestore.instance
          .collection('messages')
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          message.toJson(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.teacher.name}"),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('messages_${widget.teacher.id}_${widget.studentId}')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            );
          } else {
            List<DocumentSnapshot> items = snapshot.data.documents;
            var messages =
                items.map((i) => ChatMessage.fromJson(i.data)).toList();

            return DashChat(
              messageBuilder: (chatMessage) {
                return Container(
                  margin: EdgeInsets.only(bottom: 4),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  child: Text(chatMessage.text,style: TextStyle(color: Colors.white),),
                  decoration: BoxDecoration(
                      gradient:
                          chatMessage.user.uid != widget.studentId.toString()
                              ? LinearGradient(
                                tileMode: TileMode.mirror,
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Colors.blue[400],
                                  Colors.blue[600],
                                  Colors.blue[600],
                                  Colors.blue[400]
                                ])
                              : LinearGradient(
                                tileMode: TileMode.mirror,
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Colors.green[400],
                                  Colors.green[600],
                                  Colors.green[600],
                                  Colors.green[400]
                                ]),
                      borderRadius: BorderRadius.only(
                        bottomRight: chatMessage.user.uid == widget.studentId.toString()
                              ?Radius.circular(12):Radius.circular(0),
                          topRight: Radius.circular(12),
                          topLeft: chatMessage.user.uid != widget.studentId.toString()
                              ?Radius.circular(12):Radius.circular(0),
                          bottomLeft: Radius.circular(12))),
                );
              },
              avatarBuilder: (user) {
                // messages.
                return Container();
                // return Card(
                //   elevation: 12,
                //   shadowColor: Colors.black45,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       image: DecorationImage(image: AssetImage(user.avatar),fit: BoxFit.fill,)
                //     ),
                //   ),
                // );
              },
              user: user,
              messages: messages,
              inputDecoration: InputDecoration(
                hintText: "Message here...",
                border: InputBorder.none,
              ),
              inputContainerStyle: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              onSend: onSend,
              trailing: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: uploadFile,
                )
              ],
            );
          }
        },
      ),
    );
  }
}
