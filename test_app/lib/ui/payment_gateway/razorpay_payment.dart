import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPaymentGateway extends StatefulWidget {
  const RazorpayPaymentGateway({ Key? key }) : super(key: key);

  @override
  _RazorpayPaymentGatewayState createState() => _RazorpayPaymentGatewayState();
}

class _RazorpayPaymentGatewayState extends State<RazorpayPaymentGateway> {

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Razorpay'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(child: ElevatedButton(onPressed: () => openCheckout(),child: const Text('Pay'))),
      )
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('SUCCESS:   ${response.paymentId.toString()}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('ERROR:   ${response.code.toString()}  -  ${response.message}!');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('EXTERNAL_WALLET:   ${response.walletName}');
  }

   void openCheckout() async {
    var options = {
      'key': 'rzp_test_0q1hhQHdMBZMoh',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '9760656467', 'email': 'alihasan226@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  void dispose() {  
    super.dispose();
    _razorpay.clear();
  }
}