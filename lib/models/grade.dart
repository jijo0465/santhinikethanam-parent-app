import 'package:parent_app/models/teacher.dart';

class Grade {
  int _id;
  int _standard;
  String _division;
  int _totalStrength;
  Teacher _classTeacher;
  Teacher _asstClassTeacher;
  String _standardInRoman;

  get id => _id;
  get standard => _standard;
  get division => _division;
  get totalStrength => _totalStrength;
  get classTeacher => _classTeacher;
  get asstClassTeacher => _asstClassTeacher;
  get standardInRoman => _standardInRoman;

  Grade(this._id, this._standard, this._division, this._totalStrength,
      this._classTeacher){
    switch(this.standard){
      case 8:
        print('Standard 8');
        this._standardInRoman = 'VIII';
        break;
      case 9:
        this._standardInRoman = 'IX';
        break;
      case 10:
        this._standardInRoman = 'X';
    }
  }

  Grade.empty() {}

  setId(int id) {
    this._id = id;
  }

  setStandard(int standard) {

    this._standard = standard;
  }

  setDivision(String division) {
    this._division = division;
  }

  setTotalStrength(int totalStrength) {
    this._totalStrength = totalStrength;
  }

  setClassTeacher(Teacher classTeacher) {
    this._classTeacher = classTeacher;
  }

  setAsstClassTeacher(Teacher asstClassTeacher) {
    this._asstClassTeacher = asstClassTeacher;
  }

  factory Grade.fromMap(Map<String, dynamic> value) {
    Grade grade = Grade(
        value['id'],
        value['standard'],
        value['division'],
        value['totalStrength'],
        value['classTeacher']
//        value['asstClassTeacher']
    );
    return grade;
  }
  Map toJson() => {
    'standard': standard,
    'division': division,
  };
}
