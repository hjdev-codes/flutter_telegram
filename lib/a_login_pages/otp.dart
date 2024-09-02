import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_telegram/a_pages/page2/homepage.dart';

class OptPage extends StatefulWidget {
  const OptPage({super.key, required this.verfificationid});

  final String verfificationid;

  @override
  State<OptPage> createState() => _OptPageState();
}

class _OptPageState extends State<OptPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            textAlign: TextAlign.center,
            "We have sent an OPT to your phone. Plz verify",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: MediaQuery.sizeOf(context).height * .07,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Enter OTP",
                    hintStyle: TextStyle(fontSize: 25),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          MaterialButton(
            elevation: 0,
            color: Colors.white38,
            onPressed: () async {
              EasyLoading.show();

              try {
                PhoneAuthCredential cred = PhoneAuthProvider.credential(
                    verificationId: widget.verfificationid,
                    smsCode: controller.text);

                await FirebaseAuth.instance.signInWithCredential(cred);

                EasyLoading.dismiss();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Homepage(),
                  ),
                );
              } catch (e) {
                print(e);
              }
            },
            child: const Text(
              "Verify",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    ));
  }
}
