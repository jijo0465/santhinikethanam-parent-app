import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/models/grade.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class DiscussionsScreen extends StatefulWidget {
  // final Grade grade = Grade();
  // final Student student;
  final String date;
  final String grade;
  final int period;

  const DiscussionsScreen({Key key, this.date, this.grade, this.period}) : super(key: key);

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
  bool onVideo = false;
  ValueNotifier<bool> playButtonNotifier = ValueNotifier(false);
  String url = 'unavailable';
  StorageReference ref;
  ValueNotifier<Duration> playtime = ValueNotifier(Duration(seconds: 0));
  bool showPlayerControls = true;
  bool isFullScreen = false;
  ChewieController _chewieController;



  @override
  void initState() {

    Future.delayed(Duration(seconds: 3)).then((value){
//      setState(() {
//        showPlayerControls = false;
//      });
    });

    // TODO: implement initState
    playButtonNotifier.value = true;
    widgetIndex = 0;
    grade.setId(id);
    _playerController =
    VideoPlayerController.asset('assets/videos/smartschool.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _playerController.play();
        });
      });
    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
      fullScreenByDefault: false,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      videoPlayerController: _playerController,
      autoInitialize: false,
      autoPlay: false,
      showControls: true,
//       customControls: getPlayerControls()
    );
    _chewieController.addListener(() {
      if (_chewieController.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      }
    });

    _playerController.addListener(() async {
      await Future.delayed(Duration(seconds: 1));
      playtime.value = await _playerController.position;
    });

    onVideo = false;
//    _getVideoUrl().then((value) {
//      if(value!=null)
    _playerController =
    VideoPlayerController.network(url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _playerController.play();
          onVideo = true;
          print('VIDEO : $onVideo');
        });
        playButtonNotifier.value = false;
      });
//    });

    super.initState();
  }

  @override
  void dispose() {
    discussionListWidget.clear();
    _playerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

//  Future<String> _getVideoUrl() async {
//    StorageReference ref = FirebaseStorage.instance.ref().child("videos/${widget.grade}/${widget.date}/${widget.period}");
//    String url = (await ref.getDownloadURL()).toString();
//    if(url!=null)
//      print(url);
//    else
//      print('URL doesnt exist');
//    print(url);
//    return url;
//  }

  @override
  Widget build(BuildContext context) {
    StudentState state = Provider.of<StudentState>(context, listen: true);
    _selectedStudent = state.selectedstudent;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
//          DigiCampusAppbar(
//        icon: Icons.close,
//        onDrawerTapped: () => Navigator.of(context).pop(),
//      ),
          StreamBuilder<QuerySnapshot>(
            // key: _key,
              stream: firestore.collection('classroom_${grade.id}').snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor))
                  );
                else {
                  _items = snapshot.data.documents;
                  url = listItem(_items);
                  return  Column(
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.3,
                          width: double.infinity,
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: _playerController.value.initialized
                                    ? GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){playButtonNotifier.value = true;
                                  Future.delayed(Duration(seconds: 4)).then((value) {
                                    if(_playerController.value.isPlaying)
                                      playButtonNotifier.value = false;
                                  });},
                                  child: Container(
                                    height: 250,
                                    child: AspectRatio(
                                      aspectRatio: _playerController.value.aspectRatio,
                                      child: Chewie(

                                        controller: _chewieController,
                                      ),
                                    ),
                                  ),
                                )
                                    : Container(),
                              ),
                              ValueListenableBuilder<bool>(
                                valueListenable: playButtonNotifier,
                                builder: (context, val, _){
                                  return !val
                                      ?Container()
                                      :Container(
                                    child: Center(
                                      child: FloatingActionButton(
                                        onPressed: () {
//                          setState(() {
                                          if(_playerController.value.isPlaying) {
                                            setState(() {
                                              _playerController.pause();
                                            });
                                            playButtonNotifier.value = true;
                                          }
                                          else{
                                            setState(() {
                                              _playerController.play();
                                            });
                                            Future.delayed(Duration(seconds: 4)).then((value) {
                                              playButtonNotifier.value = false;
                                            });
                                          }
                                          _playerController.value.isPlaying
                                              ? _playerController.pause()
                                              : _playerController.play();
//                          });
                                        },
                                        child: Icon(
                                          _playerController.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Raise Doubts',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                            child: TextField(
                              onChanged: (text) {
                                if (text == '') {
                                  setState(() {
                                    color = Colors.grey;
                                  });
                                } else {
                                  setState(() {
                                    color = Colors.deepOrange[300];
                                  });
                                }
                              },
                              controller: _textFieldController,
                              // textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.start,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                hintText: 'add to discussions...',
                                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _addToDiscussions(_textFieldController.text,widget.grade,widget.date,widget.period);
                                    _textFieldController.clear();
                                  },
                                  icon: Icon(Icons.camera_alt),
                                  color: Colors.blue,
                                ),
                              ),

                              // autofocus: true,
                              // onSubmitted: (text) {
                              //   // print(text);
                              //   _addToDiscussions(text);
                              //   _textFieldController.clear();
                              //   // text = '';
                              // },
                            ),
                          ),
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey[300]),
                              child: GestureDetector(
                                child: Icon(Icons.send, color: color),
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  _addToDiscussions(_textFieldController.text,widget.grade,widget.date,widget.period);
                                  _textFieldController.clear();
                                  setState(() {
                                    color = Colors.grey;
                                  });
                                },
                              ))
                        ],
                      ),
                      SizedBox(height: 12),
                      (discussionListWidget.isNotEmpty)
                          ? Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                                  children: discussionListWidget.toList())
                            // child: listItem(_items[0]['disussion'])
                          ))
                          : Container(child: Text('No Discussions yet!!'))
                    ],
                  );
                }
              }),
        ]));
  }

  String listItem(List<DocumentSnapshot> items) {
    DocumentSnapshot item;
    for(int i=0; i<items.length; i++)
      if(items[i].documentID == '${widget.date}')
        item = _items[i];
    if(item != null)
    {
      for (; widgetIndex < item['${widget.period}'].length; widgetIndex++) {
        commentData.insert(widgetIndex, {
          'comment': item['${widget.period}'][widgetIndex]['comment'],
          'time': item['${widget.period}'][widgetIndex]['time']
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
                            item['${widget.period}'][widgetIndex]['url']),
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
                        child: Text(item['${widget.period}'][widgetIndex]['comment']),
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
        ]));}
      return item['${widget.period}'][widgetIndex]['url'];
    }
  }

  _addToDiscussions(String text,String std,String date,int period) async {
    var comment = [
      {'comment': text, 'date': DateTime.now().toUtc(),'url':'https://neatoday.org/wp-content/uploads/2016/08/young_student-e1472643979755.jpg'}
    ];
    DocumentReference documentReference =
    firestore.collection('classroom_${grade.id}').document('${widget.date}');
    firestore.runTransaction((transaction) async {
//      if(documentReference != null)
//      await transaction.set(
//          documentReference, {'${widget.period}': FieldValue.arrayUnion(comment)});
//      else
      await transaction.set(
          documentReference, {'heee': FieldValue.arrayUnion(comment)});
    });
    // documentReference.get().then((doc){
    //   if(doc.exists){
    //     documentReference.updateData({'disussion':FieldValue.arrayUnion(comment)});
    //   }else{
    //     documentReference.setData({'disussion':FieldValue.arrayUnion(comment)});
    //   }
    // });
  }
}
