class Payment {
  DateTime _dueDate;
  double _dueAmount;
  bool _paymentStatus;

  get dueDate=>_dueDate;
  get dueAmount=>_dueAmount;
  get paymentStatus=>_paymentStatus;
  
  Payment(this._dueDate, this._dueAmount, this._paymentStatus);

  setDueDate(DateTime dueDate) {
    this._dueDate = dueDate;
  }

  setDueAmount(double dueAmount) {
    this._dueAmount = dueAmount;
  }

  setPaymentStatus(bool paymentStatus) {
    this._paymentStatus = paymentStatus;
  }

  factory Payment.fromMap(Map<String, dynamic> value) {
    Payment payment = Payment(value['dueDate'], value['dueAmount'], value['paymentStatus']);
    return payment;
  }
}