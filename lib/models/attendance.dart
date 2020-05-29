class Attendance {
  Map<DateTime,bool> _attendanceLog;

  get attendanceLog=>_attendanceLog;

  Attendance(this._attendanceLog);

  setAttendance(Map<DateTime,bool> attendanceLog) {
    this._attendanceLog = attendanceLog;
  }

  factory Attendance.fromMap(Map<String, dynamic> value) {
    Attendance attendance = Attendance(value['attendanceLog']);
    return attendance;
  }
}