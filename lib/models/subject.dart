class Subject {
  int _subjectId;
  String _subjectName;
  String _shortName;
  bool _isExamable;

  get subjectId=>_subjectId;
  get subjectName=>_subjectName;
  get shortName=>_shortName;
  get isExamable=>_isExamable;

  Subject(this._subjectId,this._subjectName,this._shortName,this._isExamable);

  setSubjectId(int subjectId) {
    this._subjectId = subjectId;
  }

  setSubjectName(String subjectName) {
    this._subjectName = subjectName;
  }

  setShortName(String shortName) {
    this._shortName = shortName;
  }

  setIsExamable(bool isExamable) {
    this._isExamable = isExamable;
  }

  factory Subject.fromMap(Map<String, dynamic> value) {
    Subject subject = Subject(
      value['subjectId'],
      value['subjectName'],
      value['shortName'],
      value['isExamable']
    );
    return subject;
  }
}