import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_chat.dart';
import 'package:parent_app/redirect.dart';
import 'package:parent_app/screens/attendance_screen.dart';
import 'package:parent_app/screens/chat_screen.dart';
// import 'package:parent_app/screens/class_screen.dart';
import 'package:parent_app/screens/classroom_screen.dart';
// import 'package:parent_app/screens/home_screen.dart';
import 'package:parent_app/screens/my_school.dart';
import 'package:parent_app/screens/student_360.dart';
import 'package:parent_app/screens/call.dart';
import 'package:parent_app/screens/value_education.dart';
import 'package:parent_app/screens/scholarship_screen.dart';
import 'package:parent_app/screens/discussions_screen.dart';
import 'package:parent_app/screens/knowledge_base.dart';
import 'package:parent_app/screens/events_screen.dart';
import 'package:parent_app/screens/exams_screen.dart';
import 'package:parent_app/screens/fee_payment_screen.dart';
import 'package:parent_app/screens/live_screen.dart';
import 'package:parent_app/screens/remarks_screen.dart';
import 'package:parent_app/screens/ratings_screen.dart';
import 'package:parent_app/screens/result_screen.dart';
import 'package:parent_app/screens/school_diary_screen.dart';
import 'package:parent_app/screens/schoolbus_screen.dart';
import 'package:parent_app/screens/student_details_screen.dart';
import 'package:parent_app/screens/in_out_screen.dart';
import 'package:parent_app/screens/timetable_screen.dart';
import 'package:parent_app/screens/homeworks_screen.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/parent_state.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {

  runApp(ParentApp());
}

class ParentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginState>(
              create: (_) => LoginState.instance()),
          ChangeNotifierProvider<ParentState>(
              create: (_) => ParentState.instance()),
          ChangeNotifierProvider<StudentState>(
              create: (_) => StudentState.instance()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Color(0xff00739e),
              accentColor: Colors.deepOrange,
              fontFamily: 'Poppins'),
          supportedLocales: const [Locale('en')],
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          home: Redirect(),
          routes: <String, WidgetBuilder>{
            '/home': (context) => Redirect(),
            '/mySchool': (context) => MySchoolScreen(),
            '/student_360': (context) => Student360Screen(), 
            '/value_edu': (context) => ValueEducationScreen(),
            '/scholarship': (context) => ScholarshipScreen(),
            '/diary': (context) => SchoolDiaryScreen(),
            '/result': (context) => ResultScreen(),
            '/attendance':(context) => AttendanceScreen(),
            '/schoolbus':(context) => SchoolBusScreen(),
            '/studentdetails':(context) => StudentDetailsScreen(),
            '/inOut': (context) => InOutScreen(),
            '/timetable': (context) => TimetableScreen(),
            '/feePayment': (context) => FeePaymentScreen(),
            '/chat': (context) => ChatScreen(),
            '/digiChat': (context) => DigiChat(),
            '/exams': (context) => ExamScreen(),
            '/homeworks': (context) => HomeworksScreen(),
            '/events': (context) => EventsScreen(),
            '/remarks': (context) => RemarksScreen(),
            '/ratings': (context) => RatingsScreen(),
            '/classroom': (context) => ClassroomScreen(),
            '/discussions': (context) => DiscussionsScreen(),
            '/live': (context) => LiveScreen(),
            '/notes': (context) => KnowledgeBaseScreen(),
            '/call': (context) => CallPage(),
          },
        ));
  }
}
