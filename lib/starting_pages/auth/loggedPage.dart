import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morflutter/starting_pages/tests/sendAndFetch.dart';

class LoggedPage extends StatefulWidget {
  const LoggedPage({super.key});

  @override
  State<LoggedPage> createState() => _LoggedPageState();
}

class _LoggedPageState extends State<LoggedPage> {
  // our user is:
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('signed in as ${user?.email}'),
              MaterialButton(
                  color: Colors.purple,
                  child: Text('Sign Out'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  }),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SendAndfetch()));
                },
                color: Colors.purple,
                child: Text('Go to data'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
