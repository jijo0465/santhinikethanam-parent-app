import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/models/grade.dart';
import 'package:provider/provider.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/components/live_call_settings.dart';
import 'package:parent_app/states/student_state.dart';

class CallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  // final String channelName;
  final int id;

  /// Creates a call page with given channel name.
  const CallPage({Key key, this.id}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = true;
  final bool isflag = true;
   Firestore firestore = Firestore.instance;
  Grade grade = Grade.empty();
  int id = 4001;
  int broadcasterUid = 3001;
  int participantUid;
  List<int> participants= [];
  // int userid;
  // int id;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    grade.setId(id);
    // print('${StudentState.instance().selectedstudent.id}');
    // StudentState state = Provider.of<StudentState>(context, listen: true);
    // id = state.selectedstudent.id;
    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await AgoraRtcEngine.setClientRole(ClientRole.Audience);
    await AgoraRtcEngine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    // await AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.muteLocalAudioStream(muted);
    await AgoraRtcEngine.joinChannel(
        null,
        'class_7',
        null,
        0);

    // await AgoraRtcEngine.enableWebSdkInteroperability(true);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
      });
    };

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      participantUid = uid;
      firestore.collection('live').document('grade_7').get().then((value) {
        print('FIREBASE>>>>><<<<< FIREBASE <<<<>>>>>');
        if(value['liveBroadcastUserId']['users'] != null)  {
          for(int i=0; i<value['liveBroadcastUserId']['users'].length; i++)  {
            participants.insert(i,value['users'][i]);
          }
          participants.add(uid);
        }
        else
          participants.add(uid);
          firestore.collection('live').document('class_${grade.id}').updateData({'liveBroadcastUserId': {'users': FieldValue.arrayUnion(participants)}}).then((value) {
          print('PARTICIPANTS : $participants');
          setState(() {
            final info = 'onJoinChannel: $channel, uid: $uid';
            _infoStrings.add(info);
          });
        });
      });

      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });

      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        if (isflag) _users.add(uid);
      });

      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });

      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
      });
    };
  }

  /// Helper function to get list of native views
  // List<Widget> _getRenderViews() {
  //   final List<AgoraRenderWidget> list = [
  //     AgoraRenderWidget(0, local: true, preview: true),
  //   ];
  //   _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
  //   return list;
  // }

  /// Video view wrapper
  // Widget _videoView(view) {
  //   return Expanded(child: Container(child: view));
  // }

  /// Video view row wrapper
  // Widget _expandedVideoRow(List<Widget> views) {
  //   final wrappedViews = views.map<Widget>(_videoView).toList();
  //   return Expanded(
  //     child: Row(
  //       children: wrappedViews,
  //     ),
  //   );
  // }

  /// Video layout wrapper
  // Widget _viewRows() {
  //   final views = _getRenderViews();
  //   switch (views.length) {
  //     case 1:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[_videoView(views[0])],
  //       ));
  //     case 2:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoRow([views[0]]),
  //           _expandedVideoRow([views[1]])
  //         ],
  //       ));
  //     case 3:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoRow(views.sublist(0, 2)),
  //           _expandedVideoRow(views.sublist(2, 3))
  //         ],
  //       ));
  //     case 4:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoRow(views.sublist(0, 2)),
  //           _expandedVideoRow(views.sublist(2, 4))
  //         ],
  //       ));
  //     default:
  //   }
  //   return Container();
  // }

  /// VideoView layout
  Widget _viewVideo() {
    return Container(child: AgoraRtcEngine.createNativeView((viewId) {
      firestore.collection('live').document('grade_7').get().then((DocumentSnapshot value) {
        broadcasterUid = value['liveBroadcastChannelId'];
        print('USER BROADCAST ID-------->>>> : $broadcasterUid');
        AgoraRtcEngine.setupRemoteVideo(viewId, VideoRenderMode.Fit,
            broadcasterUid);
      });
//      print('USER BROADCAST ID-------->>>>>${_users.first}');
//      AgoraRtcEngine.setupRemoteVideo(viewId, VideoRenderMode.Fit,
//          _users.first);

      // _viewId = viewId;
      // print(widget.uid);
      // AgoraRtcEngine.setupLocalVideo(_viewId, VideoRenderMode.Fit);
      // AgoraRtcEngine.startPreview();
       //widget.uid  --> Broadcaster Uid
      // AgoraRtcEngine.startPreview();
      // AgoraRtcEngine.joinChannel(null, 'flutter', null, 0);
    }));
    // return AgoraRenderWidget(broadcasterUid, local: true, preview: true);
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // RawMaterialButton(
          //   onPressed: _onToggleMute,
          //   child: Icon(
          //     muted ? Icons.mic_off : Icons.mic,
          //     color: muted ? Colors.white : Colors.blueAccent,
          //     size: 20.0,
          //   ),
          //   shape: CircleBorder(),
          //   elevation: 2.0,
          //   fillColor: muted ? Colors.blueAccent : Colors.white,
          //   padding: const EdgeInsets.all(12.0),
          // ),
          // Flexible(
          //   flex: 2,
          //   child: GestureDetector(
          //     onLongPress: _onToggleMute,
          //     onLongPressEnd: (_) {
          //       _onToggleMute();
          //     },
          //     child: Container(
          //       // height: 50,
          //       // width: 50,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: muted ? Colors.blueAccent : Colors.white,
          //       ),
          //       padding: const EdgeInsets.all(12.0),
          //       child: Icon(
          //         muted ? Icons.mic_off : Icons.mic,
          //         color: muted ? Colors.red : Colors.white,
          //         size: 20.0,
          //       ),
          //     ),
          //   ),
          // ),
          Flexible(
            flex: 2,
            child: RaisedButton(
                shape: CircleBorder(side: BorderSide(color: Colors.black12)),
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                onPressed: () {
                  // setState(() {
                  //   checkParticipants = !checkParticipants;
                  // });
                },
                child: Icon(
                  Icons.chat,
                  color: Colors.white,
                  size: 20.0,
                )),
          ),
          Flexible(
            flex: 2,
            child: GestureDetector(
              onLongPress: _onToggleMute,
              onLongPressEnd: (_) {
                _onToggleMute();
              },
              child: RaisedButton(
                  shape: CircleBorder(side: BorderSide(color: Colors.black12)),
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                  onPressed: () {},
                  child: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                    color: muted ? Colors.red : Colors.white,
                    size: 20,
                  )),
            ),
          ),
          Flexible(
            flex: 3,
            child: RaisedButton(
              shape: CircleBorder(side: BorderSide(color: Colors.black12)),
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              onPressed: () => _onCallEnd(context),
              child: Icon(
                Icons.call_end,
                color: Colors.red,
                size: 40.0,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
                shape: CircleBorder(side: BorderSide(color: Colors.black12)),
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                onPressed: _onSwitchCamera,
                child: Icon(
                  Icons.switch_camera,
                  color: Colors.white,
                  size: 20.0,
                )),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
                shape: CircleBorder(side: BorderSide(color: Colors.black12)),
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                onPressed: () {
                  // setState(() {
                  //   checkParticipants = !checkParticipants;
                  // });
                },
                child: Icon(
                  Icons.group,
                  color: Colors.white,
                  size: 20.0,
                )),
          ),
        ],
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    // DocumentReference documentReference =
    //     firestore.collection('classroom_${grade.id}').document('live_session');
    // firestore.runTransaction((transaction) async {
    //   await transaction.update(documentReference, {
    //     'userid': FieldValue.arrayRemove([userid])
    //   });
    // });
    firestore.collection('live').document('user').updateData({'users': FieldValue.arrayRemove([participantUid])});
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () {
          _onCallEnd(context);
          return Future.value(true);
        },
        child: Center(
          child: Stack(
            children: <Widget>[
              // SizedBox(height: 8),
              // _viewRows(),
              GestureDetector(
                  onLongPress: _onToggleMute,

                  onLongPressEnd: (_) {
                    _onToggleMute();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: _viewVideo()),
              _panel(),
              _toolbar(),
              DigiCampusAppbar(
                icon: Icons.close,
                onDrawerTapped: () {
                  // DocumentReference documentReference = firestore
                  //     .collection('classroom_${grade.id}')
                  //     .document('live_session');
                  // firestore.runTransaction((transaction) async {
                  //   await transaction.update(documentReference, {
                  //     'userid': FieldValue.arrayRemove([userid])
                  //   });
                  // });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
