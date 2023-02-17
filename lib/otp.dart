import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:reach_out/phone.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  FirebaseAuth auth =FirebaseAuth.instance;

  var errorMessage='';
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var otpCode='';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25,right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/5191079.jpg'),
                height: 150,
                width: 150,
              ),
              SizedBox(
                height: 15,
              ),
              Text('Phone Verification',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text('We need to register your phone number before getting start!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value){
                  otpCode=value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    try{
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: PhoneNumber.verify, smsCode: otpCode);
                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      Navigator.pushNamedAndRemoveUntil(context, 'homePage', (route) => false);
                    }
                    catch(error){
                      print(error);
                      final snackBar=SnackBar(
                        content: Text("Wrong OTP please enter again!"),
                         backgroundColor: Colors.red,
                        action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                           // Some code to undo the change.
                        },
                      )
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text('Verify phone number'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
                },
                child: Text('Edit phone number?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
