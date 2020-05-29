import 'package:parent_app/models/test.dart';

class Exam
{
  int _examId;
  String _name;
  double _totalMarks;
  double _scoredMarks;
  bool _isUpcoming;
  DateTime _fromDate;
  DateTime _toDate;
  List<Test> _testName;

  get testId=>_examId;
  get name=>_name;
  get totalMarks=>_totalMarks;
  get scoredMarks=>_scoredMarks;
  get isUpcoming=>_isUpcoming;
  get fromDate=>_fromDate;
  get toDate=>_toDate;
  get testName=>_testName;

  Exam(this._examId, this._name, this._totalMarks, _scoredMarks,
      this._isUpcoming, this._fromDate, this._toDate,this._testName);

  setExamId(int examId) {
    this._examId = examId;
  }

  setName(String name) {
    this._name = name;
  }

  setTotalMarks(double totalMarks) {
    this._totalMarks = totalMarks;
  }

  setScoredMarks(double scoredMarks) {
    this._scoredMarks = scoredMarks;
  }
  
  setIsUpcoming(bool isUpcoming) {
    this._isUpcoming = isUpcoming;
  }

  setFromDate(DateTime fromDate) {
    this._fromDate = fromDate;
  }

  setToDate(DateTime toDate) {
    this._toDate = toDate;
  }

  setTestName(List<Test> testName) {
    this._testName= testName;
  }

  factory Exam.fromMap(Map<String, dynamic> value) {
    Exam exam = Exam(
      value['examId'],
      value['name'],
      value['totalMarks'],
      value['scoredMarks'],
      value['isUpcoming'],
      value['fromDate'],
      value['toDate'],
      value['testName']);
    return exam;
  }
}