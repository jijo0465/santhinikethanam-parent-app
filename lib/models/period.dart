import 'package:flutter/foundation.dart';
import 'package:parent_app/models/subject.dart';

class Period {
  int _pdno;
  Subject _subject;
  DateTime _startTime;
  DateTime _endTime;


  get pdno=>_pdno;
  get subject=>_subject;
  get startTime=>_startTime;
  get endTime=>_endTime;

  factory Period.fromMap(Map<String, dynamic> value) {
    Period period = Period(value['_pdno'], value['_subject'], value['_startTime'], value['_endTime']);
    return period;
  }

  Period(this._pdno,this._subject,this._startTime,this._endTime);
}