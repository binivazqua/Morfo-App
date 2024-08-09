import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:morflutter/components/texFil.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  // FIREBASE REAL TIME DATABASE USER INFORMATION:
  final _MorfoDatabase = FirebaseDatabase.instance.ref('users');
  final _MorfoDatabaseSync = FirebaseDatabase.instance.ref().keepSynced(true);

  // CREATE USER CONRTOLLERS:
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();

  // CREATE A DISPOSE METHOD FOR MEMORY PURPOSES:
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // SEND USER DATA FUNCTION:
  void sendUserData() {
    _MorfoDatabase.child(_usernameController.text)
        .set({
          'name': _nameController.text.trim(),
          'user_email': _emailController.text.trim(),
          'user_password': _passwordController.text.trim(),
          'user_id': 'none',
        })
        .then((_) => print('Data values have been sent!'))
        .catchError((error) => print('Something didnt work! Error: $error'));
  }

  // SIGN UP METHOD
  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  Future<void> singUpAndSendData() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // IF SUCCESSFUL, THEN SEND USER DATA:
      User? newUser = userCredential.user;
      if (newUser != null) {
        await _MorfoDatabase.child(newUser.uid).set({
          'name': _nameController.text.trim(),
          'username': _usernameController.text.trim(),
          'email': _emailController.text.trim(),
        });
        print('User data has been saved!');
      }
    } catch (error) {
      print('Error creating user: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hi there!',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),

                  Text(
                    'New here? Fill in some info!',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // USERNAME
                  niceTextField(
                    dataRequired: 'first name',
                    textController: _nameController,
                    p: 25,
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  // EMAIL
                  niceTextField(
                    dataRequired: 'email',
                    textController: _emailController,
                    p: 25,
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  // PASSWORD
                  niceTextField(
                    dataRequired: 'password',
                    textController: _passwordController,
                    p: 25,
                  ),

                  SizedBox(height: 20),

                  // USERNAME
                  niceTextField(
                    dataRequired: 'username',
                    textController: _usernameController,
                    p: 25,
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                      onPressed: () {}, child: Text('Verify my data')),

                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: singUpAndSendData,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.purple[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.purple[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Log in!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                  // SIGN IN BUTTON

                  // REGISTER BUTTON
                ],
              ),
            ),
          ),
        ));
  }
}
