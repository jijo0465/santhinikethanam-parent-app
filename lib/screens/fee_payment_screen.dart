import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parent_app/components/digi_key_value_display.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class FeePaymentScreen extends StatefulWidget {
  const FeePaymentScreen({Key key}) : super(key: key);

  @override
  _FeePaymentScreenState createState() => _FeePaymentScreenState();
}

class _FeePaymentScreenState extends State<FeePaymentScreen> {
  Razorpay _razorpay;
  bool feePaid;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    feePaid = false;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    //_razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _showDialog);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    //_razorpay.open(options)
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          DigiCampusAppbar(
            icon: Icons.close,
            onDrawerTapped: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: 12),
          DigiScreenTitle(text: 'Fee Payment'),
          SizedBox(height: 12),
          Container(
            height: 200,
            child: Card(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Fee Payment Due Details :',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: 100,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            DigiKeyValueDisplay(
                                textKey: 'Due Date ',
                                textValue: DateTime.now()
                                    .add(Duration(days: 5))
                                    .toString(),
                                textColor: Colors.black),
                            DigiKeyValueDisplay(
                                textKey: 'Due Amount ',
                                textValue: '2000',
                                textColor: Colors.black),
                            DigiKeyValueDisplay(
                                textKey: 'Payment Status ',
                                textValue: feePaid ? 'Done' : 'Pending',
                                textColor: Colors.black),
                          ]),
                    ),
                    SizedBox(height: 12),
                  ]),
            ),
          ),
          SizedBox(height: 12),
          RaisedButton(
            onPressed: feePaid ? null : openCheckout,
            child: Text(
              'Pay Fee',
            ),
            textColor: Colors.white,
            elevation: 6,
            textTheme: ButtonTextTheme.primary,
            color: Colors.blue[800],
            splashColor: Colors.blueGrey[200],
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            // disabledElevation: null,
          )
        ],
      ),
    );
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_SmEPwD7KlSmGwd',
      'amount': 200000,
      'name': 'Christ Nagar Public School',
      'description': 'Term II Fees',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm', 'upi']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _showDialog(response.paymentId, response.orderId, response.signature);
    setState(() {
      this.feePaid = true;
    });
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  void _showDialog(String paymentId, String orderId, String signature) {
    AwesomeDialog(
        context: this.context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        tittle: 'Succes',
        desc:
            'Payment Id : $paymentId \nOrder Id : $orderId \nSignature : $signature',
        btnOkOnPress: () {

        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          setState(() {
            this.feePaid = true;
          });
        }).show();
  }
}
