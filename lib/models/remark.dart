import 'package:parent_app/models/teacher.dart';

class Remark {
  int _id;
  String _remarks;
  Teacher _teacher;

  get id=>_id;
  get remarks=>_remarks;
  get teacher=>_teacher;

  Remark(this._id, this._remarks, this._teacher);

  setId(int id) {
    this._id = id;
  }

  setRemarks(String remarks) {
    this._remarks = remarks;
  }

  setTeacher(Teacher teacher) {
    this._teacher = teacher;
  }

  factory Remark.fromMap(Map<String, dynamic> value) {
    Remark remark = Remark(value['id'], value['remarks'], value['teacher']);
    return remark;
  }
}