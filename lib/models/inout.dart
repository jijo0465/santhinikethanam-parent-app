class InOut {
  DateTime _date;
  DateTime _schoolInTime;
  DateTime _schoolOutTime;
  DateTime _amBusInTime;
  DateTime _amBusOutTime;
  DateTime _pmBusInTime;
  DateTime _pmBusOutTime;

  get date => _date;
  get schoolInTime => _schoolInTime;
  get schoolOutTime => _schoolOutTime;
  get amBusInTime => _amBusInTime;
  get amBusOutTime => _amBusOutTime;
  get pmBusInTime => _pmBusInTime;
  get pmBusOutTime => _pmBusOutTime;

  InOut(this._date, this._schoolInTime, this._schoolOutTime, this._amBusInTime,
      this._amBusOutTime, this._pmBusInTime, this._pmBusOutTime);

  setDate(DateTime date) {
    this._date = date;
  }

  setSchoolInTime(DateTime schoolInTime) {
    this._schoolInTime = schoolInTime;
  }

  setSchoolOutTime(DateTime schoolOutTime) {
    this._schoolOutTime = schoolOutTime;
  }

  setAmBusInTime(DateTime amBusInTime) {
    this._amBusInTime = amBusInTime;
  }

  setAmBusOutTime(DateTime amBusOutTime) {
    this._amBusOutTime = amBusOutTime;
  }

  setPmBusInTime(DateTime pmBusInTime) {
    this._pmBusInTime = pmBusInTime;
  }

  setPmBusOutTime(DateTime pmBusOutTime) {
    this._pmBusOutTime = pmBusOutTime;
  }

  factory InOut.fromMap(Map<String, dynamic> value) {
    InOut inOut = InOut(
        value['date'],
        value['schoolInTime'],
        value['schoolOutTime'],
        value['amBusInTime'],
        value['amBusOutTime'],
        value['pmBusInTime'],
        value['pmBusOutTime']);
    return inOut;
  }
}
