import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

import '../components/round_botton.dart';
import 'chat_screen.dart';
//import '../components/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth =FirebaseAuth.instance;
  String ? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email=value;
                },

                decoration: kTestFieldDecoration.copyWith(hintText: 'Enter your email')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password=value;
                },
              decoration: kTestFieldDecoration.copyWith(hintText: 'Enter your Password')),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(title: 'LoG iN',color: Colors.lightBlueAccent,
              onPressed: ()async {
                final newUser = await _auth.signInWithEmailAndPassword(email: email!, password: password!);

                if(newUser.user!=null){
                  Navigator.pushNamed(context, ChatScreen.id);

                }
              },),
          ],
        ),
      ),
    );
  }
}
