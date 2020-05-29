class Test {
  int _testId;
  String _name;
  DateTime _testDateTime;
  double _totalHours;
  double _totalMarks;
  double _scoredMarks;

  get testId => _testId;
  get name => _name;
  get testDateTime => _testDateTime;
  get totalHours => _totalHours;
  get totalMarks => _totalMarks;
  get scoredMarks => _scoredMarks;

  Test(this._testId, this._name, this._testDateTime, this._totalHours,
      this._totalMarks, this._scoredMarks);

  setTestId(int testId) {
    this._testId = testId;
  }

  setName(String name) {
    this._name = name;
  }

  setTestDateTime(DateTime testDateTime) {
    this._testDateTime = testDateTime;
  }

  setTotalHours(double totalHours) {
    this._totalHours = totalHours;
  }

  setTotalMarks(double totalMarks) {
    this._totalMarks = totalMarks;
  }

  setScoredMarks(double scoredMarks) {
    this._scoredMarks = scoredMarks;
  }

  factory Test.fromMap(Map<String, dynamic> value) {
    Test test = Test(
      value['testId'],
      value['name'],
      value['testDateTime'],
      value['totalHours'],
      value['totalMarks'],
      value['scoredMarks']);
    return test;
  }
}
