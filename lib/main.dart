import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

void main() =>runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    )
);
class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Razorpay razorpay;
  TextEditingController textEditingController =new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void handlerPaymentSuccess(){
    print("Payment Success");
    Toast.show("Payment Success", context);
  }

  void handlerErrorFailure(){
    print("Payment Error");
    Toast.show("Payment Error", context);
  }

  void handlerExternalWallet(){
    print("External Wallet");
    Toast.show("External Wallet", context);
  }

  void openCheckout(){
    var options = {
      "key": "rzp_test_g6ggnb0Dw7RNtc",
      "amount": num.parse(textEditingController.text)*100,
      "name":"Payment",
      "description":"Payment ",
      "prefill": {
        "contact": "##########",
        "email":"vaibhavkarnwal2812@gmail.com",
      },
      "external": {
        "wallets": ["RazorPay"]
      }
    };

    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RazorPay"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "Amount to Pay"
                ),
              ),
              SizedBox(height: 12,),
              ElevatedButton(
                onPressed: (){
                  openCheckout();
                },
                child: Text("Pay Now",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
