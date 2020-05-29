import 'package:flutter/widgets.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/services/digi_local_sql.dart';

class StudentState with ChangeNotifier {
  List<Student> _students=List();
  Student _selectedStudent;

  StudentState.instance() {
    DigiLocalSql().getAllStudents().then((value) {
      _students = value;
      setAllStudents(_students);
    });
  }

  List<Student> get allstudents => _students;
  Student get selectedstudent => _selectedStudent;

  setStudent(Student student) async {
    this._selectedStudent = student;
    notifyListeners();
  }

  setAllStudents(List<Student> students) async {
    this._students = students;
    this._selectedStudent = students.first;
    print(_selectedStudent.name);
    // this.setStudent(students.first);
    notifyListeners();
  }
}
