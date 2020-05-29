class Event {
  String _imageUrl;
  DateTime _fromDate;
  DateTime _toDate;
  String _description;

  get imageUrl=>_imageUrl;
  get fromDate=>_fromDate;
  get toDate=>_toDate;
  get description=>_description;

  Event(this._imageUrl, this._fromDate, this._toDate, this._description);

  setImageUrl(String imageUrl) {
    this._imageUrl = imageUrl;
  }

  setFromDate(DateTime fromDate) {
    this._fromDate = fromDate;
  }

  setToDate(DateTime toDate) {
    this._toDate = toDate;
  }

  setDescription(String description) {
    this._description = description;
  }

  factory Event.fromMap(Map<String, dynamic> value) {
    Event event = Event(value['imageUrl'], value['fromDate'], value['toDate'], value['description']);
    return event;
  }
}