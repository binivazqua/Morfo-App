import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:morflutter/info/sendSensorData.dart';
import 'package:morflutter/starting_pages/auth/authPage.dart';
import 'package:morflutter/starting_pages/auth/loggedPage.dart';
import 'package:morflutter/starting_pages/auth/loginPage.dart';
import 'package:morflutter/starting_pages/tests/sendAndFetch.dart';
import 'package:morflutter/starting_pages/ui/homepage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('SIGNED IN');
                return Sendsensordata();
              } else {
                print('NOT SIGNED IN');
                return AuthPage();
              }
            }));
  }
}
