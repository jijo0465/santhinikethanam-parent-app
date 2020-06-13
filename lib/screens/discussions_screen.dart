import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:parent_app/components/digi_alert.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/models/grade.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/screens/icons.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class DiscussionsScreen extends StatefulWidget {
  // final Grade grade = Grade();
  // final Student student;
  final String date;
  final String grade;
  final String url;
  final int period;

  const DiscussionsScreen({Key key, this.date, this.grade, this.period, this.url}) : super(key: key);

  @override
  _DiscussionsScreenState createState() => _DiscussionsScreenState();
}

class _DiscussionsScreenState extends State<DiscussionsScreen> {
  // final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // var _key;
  // ListModel<int> _list;
  final TextEditingController _textFieldController =
      new TextEditingController();
  Student _selectedStudent;
  List<Widget> discussionListWidget = [];
  List<DocumentSnapshot> _items;
  List<Map<String, dynamic>> commentData = [];
  DocumentSnapshot addItem;
  Grade grade = Grade.empty();
  int id = 4001;
  int widgetIndex;
  Firestore firestore = Firestore.instance;
  VideoPlayerController _playerController;
  Color color = Colors.grey;
  StorageReference ref;
  String url;
  ValueNotifier<Duration> playtime = ValueNotifier(Duration(seconds: 0));
  bool showPlayerControls = true;
  bool isFullScreen = false;
//  bool isVideoLoaded;
  ChewieController _chewieController;

  @override
  void initState() {

//    Future.delayed(Duration(seconds: 3)).then((value){
//      setState(() {
//        showPlayerControls = false;
//      });
//    });
    // TODO: implement initState
//    isVideoLoaded = false;
    widgetIndex = 0;
    grade.setId(id);
//    setState(() {
//      isVideoLoaded = true;
//    });
    _playerController =
    VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _playerController.pause();
        });
      });
//    _chewieController = ChewieController(
//      allowedScreenSleep: false,
//      allowFullScreen: false,
//      fullScreenByDefault: false,
//      deviceOrientationsAfterFullScreen: [
//        DeviceOrientation.portraitUp,
//        DeviceOrientation.portraitDown,
//      ],
//      videoPlayerController: _playerController,
//      autoInitialize: false,
//      placeholder: Container(child: Center(child: CupertinoActivityIndicator(),),),
//      autoPlay: false,
//      showControls: true,
//      isLive: false,
////      customControls: getPlayerControls()
//
////       customControls: getPlayerControls()
//    );
//    _chewieController.addListener(() {
//      if (_chewieController.isFullScreen) {
//        SystemChrome.setPreferredOrientations([
//          DeviceOrientation.portraitUp,
//          DeviceOrientation.portraitDown,
//        ]);
//      }
//    });

//    _playerController.addListener(() async {
//      await Future.delayed(Duration(seconds: 1));
//      playtime.value = await _playerController.position;
//    });
//    getVideoUrl();
//    _playerController = VideoPlayerController();
//    getVideoUrl().then((value) {
//      url = value;
//      setState(() {
//        isVideoLoaded = true;
//      });
//    });
//    firestore.collection('grade_${widget.grade}').document(widget.date).get().then((value) {
//      if(value.data != null) {
//        url = value['period_${widget.period}']['videoUrl'];
//
//      }
//    });
//    if(url != null)
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    discussionListWidget.clear();
    _playerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _chewieController = ChewieController(
      aspectRatio: _playerController.value.aspectRatio,
      allowedScreenSleep: false,
      allowFullScreen: false,
      fullScreenByDefault: false,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      videoPlayerController: _playerController,
      autoInitialize: false,
      placeholder: Container(child: Center(child: CupertinoActivityIndicator(),),),
      autoPlay: false,
      showControls: true,
      isLive: false,
//      customControls: getPlayerControls()

//       customControls: getPlayerControls()
    );
    StudentState state = Provider.of<StudentState>(context, listen: true);
    _selectedStudent = state.selectedstudent;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
        body: Stack(
          children: [
            Column(children: <Widget>[
//              Container(
//                color: Theme.of(context).primaryColor,
//                height: MediaQuery.of(context).padding.top,
//              ),
              Container(
//            width: isFullScreen?MediaQuery.of(context).size.width:MediaQuery.of(context).size.height,
//            height: isFullScreen?MediaQuery.of(context).size.width:MediaQuery.of(context).size.height*0.3,
                color: Colors.black,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
//                          setState(() {
//                            showPlayerControls = !showPlayerControls;
//                          });
                      },
                      child: Container(
                        color: Colors.black,
//                      width: double.infinity,
//                      height: MediaQuery.of(context).size.height*0.45,
//                      n?double.infinity:MediaQuery.of(context).size.height*0.3,
                        child: Center(
                              child: _playerController.value.initialized
                                  ? GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        showPlayerControls = !showPlayerControls;
                                      });
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height,
                                      child: Chewie(
                                        controller: _chewieController,
                                      ),
                                    ),
                                  )
                                  : Container(),
                            )
                      ),
                    ),

                  ],
                ),
              ),
//      SizedBox(height: 12),
//      Text(
//            'Discussions',
//            textAlign: TextAlign.left,
//            style: TextStyle(
//              color: Colors.black,
//              fontSize: 16,
//            ),
//      ),
//      SizedBox(
//            height: 12,
//      ),
//      Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              Container(
//                height: 40,
//                width: MediaQuery.of(context).size.width - 60,
//                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//                child: TextField(
//                  onChanged: (text) {
//                    if (text == '') {
//                      setState(() {
//                        color = Colors.grey;
//                      });
//                    } else {
//                      setState(() {
//                        color = Colors.deepOrange[300];
//                      });
//                    }
//                  },
//                  controller: _textFieldController,
//                  // textAlignVertical: TextAlignVertical.center,
//                  textAlign: TextAlign.start,
//                  cursorColor: Colors.blue,
//                  decoration: InputDecoration(
//                    hintText: 'add to discussions...',
//                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
//                    border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(20),
//                    ),
//                    suffixIcon: IconButton(
//                      onPressed: () {
//                        _addToDiscussions(_textFieldController.text);
//                        _textFieldController.clear();
//                      },
//                      icon: Icon(Icons.camera_alt),
//                      color: Colors.blue,
//                    ),
//                  ),
//
//                  // autofocus: true,
//                  // onSubmitted: (text) {
//                  //   // print(text);
//                  //   _addToDiscussions(text);
//                  //   _textFieldController.clear();
//                  //   // text = '';
//                  // },
//                ),
//              ),
//              Container(
//                  height: 40,
//                  width: 40,
//                  decoration: BoxDecoration(
//                      shape: BoxShape.circle, color: Colors.grey[300]),
//                  child: GestureDetector(
//                    child: Icon(Icons.send, color: color),
//                    behavior: HitTestBehavior.translucent,
//                    onTap: () {
//                      _addToDiscussions(_textFieldController.text);
//                      _textFieldController.clear();
//                      setState(() {
//                        color = Colors.grey;
//                      });
//                    },
//                  ))
//            ],
//      ),
//      SizedBox(height: 12),
//      StreamBuilder<QuerySnapshot>(
//              // key: _key,
//              stream: firestore.collection('classroom_${grade.id}').snapshots(),
//              builder:
//                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                if (!snapshot.hasData)
//                  return Center(
//                    child: CircularProgressIndicator(
//                      valueColor: AlwaysStoppedAnimation<Color>(
//                          Theme.of(context).primaryColor),
//                    ),
//                  );
//                else {
//                  _items = snapshot.data.documents;
////              listItem(_items);
//                  // print('item: ${_items[0]}');
//                  // setState(() {
//                  // AnimatedList.of(context).insertItem(0);
//                  // Future.delayed(Duration(milliseconds: 200))
//                  //     .then((value) => _listKey.currentState.insertItem(0));
//
//                  // });
//                  // return listItem(_items[0]);'
//                  // commentData.addAll(_items[0]['']['']);
//                  return (_items.isNotEmpty)
//                      ? Expanded(
//                          child: SingleChildScrollView(
//                              child: Column(
//                                  children: discussionListWidget.reversed.toList())
//                              // child: listItem(_items[0]['disussion'])
//                              ))
//                      : Container(child: Text('No Discussions yet!!'));
//                }
//              }),
    ]),
//            DigiAlert(title:'My Classroom', text: 'Classroom at fingertips',icon: DigiIcons.virtual_class)
          ],
        ));
  }
//  getVideoUrl() async {
//    String videoUrl;
//    firestore.collection('grade_${widget.grade}').document(widget.date).get().then((value) {
//      if(value.data != null) {
//        videoUrl = value['period_${widget.period}']['videoUrl'];
//        print('videoURL: $videoUrl');
//        initialisePlayer(videoUrl);
//      }
//    });
//  }

  listItem(List<DocumentSnapshot> item) {
    for (; widgetIndex < item[0]['disussion'].length; widgetIndex++) {
      commentData.insert(widgetIndex, {
        'comment': item[0]['disussion'][widgetIndex]['comment'],
        'date': item[0]['disussion'][widgetIndex]['date']
      });

      print(commentData[widgetIndex]['comment']);
      // print('itemval: ${item[0]['disussion'][widgetIndex]['comment']}');
      discussionListWidget.add(Column(children: <Widget>[
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 5 / 6,
          child: Row(
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                // margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image:
                          // AssetImage(''),
                          NetworkImage(
                              item[0]['disussion'][widgetIndex]['url']),
                      fit: BoxFit.fill),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(item[0]['disussion'][widgetIndex]['comment']),
                ),
              )),
            ],
          ),
        ),
        Divider(
          indent: 5,
          endIndent: 5,
          color: Colors.black38,
          // thickness: 2,
        )
      ]));
    }
  }

  _addToDiscussions(String text) async {
    var comment =
      {'comment': text, 'date': DateTime.now().toUtc(),'url':'https://neatoday.org/wp-content/uploads/2016/08/young_student-e1472643979755.jpg'};
    firestore.collection('grade_${widget.grade}').document('${widget.date}').setData(
        {'period_${widget.period}': {'pdno': '${widget.period}', 'discussion': FieldValue.arrayUnion([comment])}},merge: true
    );
//    DocumentReference documentReference =
//        firestore.collection('classroom_${grade.id}').document('Session_1');
//    firestore.runTransaction((transaction) async {
//      await transaction.update(
//          documentReference, {'disussion': FieldValue.arrayUnion(comment)});
//    });
    // documentReference.get().then((doc){
    //   if(doc.exists){
    //     documentReference.updateData({'disussion':FieldValue.arrayUnion(comment)});
    //   }else{
    //     documentReference.setData({'disussion':FieldValue.arrayUnion(comment)});
    //   }
    // });
  }
  Widget getPlayerControls(){
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: ValueListenableBuilder<Duration>(
              valueListenable: playtime,
              builder: (context, val, _) {
                print(_playerController.value.duration);
                print(val);
                return Text(
                  '${val.inMinutes} : ${val.inSeconds % 60}',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ValueListenableBuilder<Duration>(
              builder: (context, val, _) {
                return Text(
                  '${_playerController.value.duration.inHours}:${_playerController.value.duration.inMinutes}:${_playerController.value.duration.inSeconds % 60}',
                  style: TextStyle(color: Colors.white),
                );
              },
              valueListenable: playtime,
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon:
                    Icon(Icons.fast_rewind, color: Colors.white),
                    onPressed: () async {
                      Duration duration = Duration(
                          seconds: (await _playerController.position)
                              .inSeconds -
                              10);
                      _playerController.seekTo(duration);
                    }),
                FloatingActionButton(
//                  backgroundColor:
//                  Theme.of(context).primaryColor.withOpacity(0.7),
                  onPressed: () {
                    setState(() {
                      _playerController.value.isPlaying
                          ? _playerController.pause()
                          : _playerController.play();
                    });
                  },
                  child: Icon(
                    _playerController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.fast_forward,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      Duration duration = Duration(
                          seconds: (await _playerController.position)
                              .inSeconds +
                              10);
                      _playerController.seekTo(duration);
                    })
              ],
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(
                    Icons.fullscreen,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _chewieController.toggleFullScreen();
                  }))
        ],
      ),
    );

  }
}
