import 'package:parent_app/models/grade.dart';

class Student {
  int id;
  String _studentId;
  int age;
  double rewards;
  Grade grade;
  String name;
  String parentName;
  String classTeacher;
  String bloodGroup;
  String dateOfBirth;
  String photoUrl;

  get studentId => _studentId;

  Student(
      this.id,
      this._studentId,
      this.name,
      //this.parentName,
      //this.classTeacher,
      this.grade,
//      this.dateOfBirth,
//      this.bloodGroup,
//      this.photoUrl
      );

  factory Student.fromMap(Map<String, dynamic> value) {
    // print(value.toString());
    Student student = Student(
        //value['id'],
        value['id'],
        value['studentId'],
        value['name'],
        Grade.fromMap(value['grade'])
        //value['parentName'],
        //value['classTeacher'],
        //value['grade'],
//        value['date_of_birth'],
//        value['blood_group'],
//        value['photo_url']
    );
        //student.studentId = student.id;
    // student.id=value['id'];
    // student.id=value['student_id'];
    // student.name=value['name'];
    // //student.parentName=value['parentName'];
    // //student.classTeacher=value['classTeacher'];
    // //student.grade=value['grade'];
    // student.dateOfBirth=value['date_of_birth'];
    // student.bloodGroup=value['blood_group'];
    // //student.age=value['age'];
    // //student.rewards=value['rewards'];
    // student.photoUrl=value['photo_url'];
    return student;
  }
  Map toJson() => {
    'name': name,
    'grade': grade,
  };
}
