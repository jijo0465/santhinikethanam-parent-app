class Teacher {
  int id;
  int teacherId;
  int age;
  List<Map<int,String>> grade;
  Map<int,String> mainGrade;
  String name;
  String contactNo;
  String bloodGroup;
  String dateOfBirth;
  String photoUrl;

  Teacher({this.id,this.teacherId,this.grade,this.mainGrade,this.name,this.contactNo,this.bloodGroup,this.dateOfBirth,this.photoUrl});

  factory Teacher.fromMap(Map<String,dynamic> value){
    // print(value.toString());
    Teacher teacher=Teacher();
    teacher.id=value['id'];
    teacher.id=value['teacherId'];
    teacher.name=value['name'];
    teacher.contactNo=value['contactNo'];
    //teacher.grade=value['grade'];
    //teacher.mainGrade=value['mainGrade'];
    teacher.dateOfBirth=value['dateOfBirth'];
    teacher.bloodGroup=value['bloodGroup'];
    //teacher.age=value['age'];
    //teacher.rewards=value['rewards'];
    teacher.photoUrl=value['photoUrl'];
    return teacher;
  }
}