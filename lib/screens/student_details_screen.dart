import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/components/digi_key_value_display.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/services/digi_attendance.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:math';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class StudentDetailsScreen extends StatefulWidget {
  final int pageNo = 0;
  const StudentDetailsScreen({
    Key key,
    int pageNo,
  }) : super(key: key);

  @override
  _StudentDetailsScreenState createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  bool isFading = false;
  //bool isFirst=true;
  int page;
  PageController _pageController;
  SharedPreferences _pref;
  StudentState state;
  Student selectedStudent;
  File  _image;
  final picker = ImagePicker();
  Firestore firestore = Firestore.instance;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    StorageReference storageReference;
    if(pickedFile!=null)
      _pref = await SharedPreferences.getInstance();
        _image = File(pickedFile.path);
    // getting a directory path for saving
    final directory = await getApplicationDocumentsDirectory();
    // copy the file to a new path
    final File newImage = await _image.copy('${directory.path}/${getRandomString(5)}.png');
    _pref.setString("photoPath", newImage.path);
    state.setPhotoUrl(newImage.path);
    print(state.selectedstudent.photoUrl);
    if (_image!=null) {
      storageReference =
          FirebaseStorage.instance.ref().child("images/students/student_image/${state.allstudents[0].studentId}");
    }
    final StorageUploadTask uploadTask = storageReference.putFile(_image);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());


    firestore.collection('students').document('${state.allstudents[0].studentId}').setData(
        {'name': '${selectedStudent.name}', 'photo_url': url, 'uid': '${state.allstudents[0].studentId}','grade': '${selectedStudent.grade}'},merge: true
    );
    print("URL is $url");
    print(newImage.path);
  }
  String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(

      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  // Student().fromMap('{"id":1001,"name":"Karthyaayini","parentName":"Ajith"}');
  @override
  void initState() {
    //selectedStudent=_students.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<StudentState>(context, listen: true);
    selectedStudent = state.selectedstudent;
    // String displayStudentId;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
//          padding: EdgeInsets.only(top: 35),
              height: 400,
              width: double.infinity,
              child: Image.asset(
                'assets/images/school.jpg',
                fit: BoxFit.cover,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  children: <Widget>[
//                DigiCampusAppbar(
//                  icon: Icons.home,
////                  trailing: Icon(Icons.notifications_active),
//                  onDrawerTapped: () {
//                    Navigator.of(context).pop();
//                  },
//                ),
                    SizedBox(height: MediaQuery.of(context).padding.top+12),
                    AnimatedOpacity(
                      opacity: isFading ? 0 : 1,
                      duration: Duration(milliseconds: isFading ? 400 : 100),
                      child: AnimatedContainer(

                        //color: Colors.blue,
                          height: isFading ? 4 : 38,
                          width: isFading ? 4 : 200,
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: isFading ? 400 : 100),
                          child: Text(
                            selectedStudent.name,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              //backgroundColor: Colors.blue[800],
                              fontSize: 22,
                            ),
                          )),
                    ),
                    SizedBox(height: 6),
                    Consumer<StudentState>(builder: (context, studentState, _) {
                      // selectedStudent = studentState.selectedstudent;
                      // displayStudentId = 'S-' + selectedStudent.id.toString();
                      int initialPage = studentState.allstudents.indexOf(selectedStudent);
                      print(initialPage);
                      _pageController = PageController(viewportFraction: 0.65, initialPage: initialPage);
                      _pageController.addListener(() {
                        page = _pageController.page.truncate();
                        print(_pageController.page.toStringAsFixed(1));
                        if (_pageController.page
                            .toStringAsFixed(1)
                            .startsWith(RegExp(r'^[0-9].5$'))) {
                          setState(() {
                            isFading = true;
                          });
                        } else if (_pageController.page
                            .toStringAsFixed(1)
                            .startsWith(RegExp(r'^[0-9].0$'))) {
                          setState(() {
                            isFading = false;
                            // selectedStudent = _students.elementAt(page);
                          });
                        }
                      });
                      return Container(
                        height: 240,
                        child: PageView.builder(
                            onPageChanged: (int pg) {
                              StudentState state =
                              Provider.of<StudentState>(context, listen: false);
                              state.setStudent(state.allstudents.elementAt(pg));
                            },
                            controller: _pageController,
                            itemCount: studentState.allstudents.length,
                            itemBuilder: (context, index) {
                              return Hero(
                                tag: studentState.allstudents.elementAt(index).id.toString(),
                                child: Center(
                                  child: Container(
                                    child: ClipOval(
                                        child: studentState.selectedstudent.photoUrl==null?Container(
                                          child: Image.asset('assets/images/user.png',color: Colors.grey,),
                                        ):
                                        Image(image: FileImage(File(studentState.selectedstudent.photoUrl)),fit: BoxFit.cover,)),
                                    height: 150,
                                    width: 150,
                                  ),
                                ),
                              );
                            }),
                      );
                    }),
                    GestureDetector(child: Text('Edit Photo',style: TextStyle(color: Colors.white),),
                    onTap:getImage,
                    ),
                    SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        //color: Colors.blue[800],
                        //alignment: Alignment.center,
                        //width:MediaQuery.of(context).size.width,
                        child: Consumer<StudentState>(
                            builder: (context,studentState,_) {
                              print(studentState.selectedstudent.photoUrl);
                              return Container(
//                          color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 60),
//                                    Container(
//
//                                      child: Text(
//                                        'Student ID : S-${studentState.selectedstudent.studentId}',
//                                        style: TextStyle(fontSize: 16, color: Colors.white),
//                                      ),
//                                    ),
                                    SizedBox(height: 6),
                                    DigiKeyValueDisplay(
                                        textKey: 'Name',
                                        textValue: '${studentState.selectedstudent.name}',
                                        textColor: Colors.white),
//                            DigiKeyValueDisplay(
//                                textKey: 'Parent Name',
//                                textValue: '<P_Name>',
//                                textColor: Colors.white),
//                            DigiKeyValueDisplay(
//                                textKey: 'Class Teacher',
//                                textValue: '<T_Name>',
//                                textColor: Colors.white),
                                    DigiKeyValueDisplay(
                                        textKey: 'Class',
//                                  textValue: 'fdsa',
                                        textValue: '${studentState.selectedstudent.grade.standard} th',
                                        textColor: Colors.white),
                                    DigiKeyValueDisplay(
//                                textValue: 'fds',
                                        textKey: 'Div',
                                        textValue: ' A ',
                                        textColor: Colors.white),
//                            DigiKeyValueDisplay(
//                                textKey: 'Age',
//                                textValue: '<Age>',
//                                textColor: Colors.white),
//                            DigiKeyValueDisplay(
//                                textKey: 'Blood Group',
//                                textValue: '<Type>',
//                                textColor: Colors.white),
//                            DigiKeyValueDisplay(
//                                textKey: 'Rewards',
//                                textValue: '<**@*@*@**>',
//                                textColor: Colors.white),

                                    // DigiKeyValueDisplay(),
                                    // DigiKeyValueDisplay(),
                                    SizedBox(height: 6),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.4,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                            hoverColor: Theme.of(context).primaryColor.withOpacity(0.7),
                                            splashColor: Theme.of(context).primaryColor.withOpacity(0.4),
                                            color: Colors.white.withOpacity(0.9),
                                            onPressed: ()async{
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Back'),),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.4,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                            hoverColor: Theme.of(context).primaryColor.withOpacity(0.7),
                                            splashColor: Theme.of(context).primaryColor.withOpacity(0.4),
                                            color: Colors.white.withOpacity(0.9),
                                            onPressed: ()async{
                                              Navigator.of(context).pop();
                                              LoginState.instance().signOut();
                                            },
                                            child: Text('Logout'),),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8,)
                                  ],
                                ),
                              );
                            }
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        height: 120 - MediaQuery.of(context).padding.top,
                        width: MediaQuery.of(context).size.width,
                      ),
                    )
                  ],
                ),
              ),
            ),
//        Container(
//          height: 395,
//          child: Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  alignment: Alignment.centerLeft,
//                  child: GestureDetector(
//                    behavior: HitTestBehavior.translucent,
//                    child: Icon(CupertinoIcons.left_chevron,
//                        size: 30, color: Colors.white.withOpacity(0.9)),
//                    onTap: () async {
//                      _pageController.previousPage(
//                          duration: Duration(milliseconds: 500),
//                          curve: Curves.linear);
//                    },
//                  ),
//                ),
//              ),
//              Expanded(
//                child: Container(
//                  alignment: Alignment.centerRight,
//                  child: GestureDetector(
//                    behavior: HitTestBehavior.translucent,
//                    child: Icon(CupertinoIcons.right_chevron,
//                        size: 30, color: Colors.white.withOpacity(0.9)),
//                    onTap: () {
//                      _pageController.nextPage(
//                          duration: Duration(milliseconds: 500),
//                          curve: Curves.linear);
//                    },
//                  ),
//                ),
//              )
//            ],
//          ),
//        )
          ],
        ));
  }
}
