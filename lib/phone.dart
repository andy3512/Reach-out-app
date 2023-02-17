import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  static String verify='';

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  TextEditingController countryCode=TextEditingController();
  var phone='';
  @override
  void initState() {
    // TODO: implement initState
    countryCode.text='+91';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width:40,
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                          controller: countryCode,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                        child: Text(
                          '|',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 36
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value){
                            phone=value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone number',
                          ),
                        ),
                      )
                    ],
                  )
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()async{
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '${countryCode.text+phone}',
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        PhoneNumber.verify=verificationId;

                        Navigator.pushNamed(context, 'otp');
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                    //
                  },
                  child: Text('Send the code'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
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
