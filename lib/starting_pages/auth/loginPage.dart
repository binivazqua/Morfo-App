import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:morflutter/components/texFil.dart';
import 'package:morflutter/design/constants.dart';

class MorfoLoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const MorfoLoginPage({super.key, required this.showRegisterPage});

  @override
  State<MorfoLoginPage> createState() => MorfoLoginPageState();
}

class MorfoLoginPageState extends State<MorfoLoginPage> {
  // FIREBASE REAL TIME DATABASE USER INFORMATION:
  final _MorfoDatabase = FirebaseDatabase.instance.ref('users');

  // CREATE USER CONRTOLLERS:
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  // SIGN IN METHOD:
  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
    print("FUNCTION DOING ITS THING...");
  }

  // CREATE AN UPDATE USER ID METHOD:
  void updateUserID(DatabaseReference branch, User? user) {
    String? userID = user?.uid.trim();

    branch
        .child(_usernameController.text)
        .update(userID.toString() as Map<String, Object?>);
  }

  // CREATE A DISPOSE METHOD FOR MEMORY PURPOSES:
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBranch = _MorfoDatabase.child(_usernameController.text);
    return Scaffold(
        backgroundColor: morfoBlack,
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                        'lib/design/logos/cuadrado_blanco_trippypurple-removebg-preview.png'),
                    width: 150,
                  ),

                  Text(
                    '¡Hola de nuevo!',
                    style: TextStyle(color: morfoWhite, fontSize: 15),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  niceTextField(
                    dataRequired: 'Username',
                    textController: _usernameController,
                    p: 25,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // USERNAME
                  niceTextField(
                      dataRequired: 'Email',
                      textController: _emailController,
                      p: 25),

                  SizedBox(
                    height: 20,
                  ),
                  // PASSWORD
                  niceTextField(
                      dataRequired: 'Password',
                      textController: _passwordController,
                      p: 25),

                  SizedBox(height: 45),

                  GestureDetector(
                    onTap: signIn,
                    onDoubleTap: () => updateUserID(
                        userBranch, FirebaseAuth.instance.currentUser),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      decoration: BoxDecoration(
                          color: darkPeriwinkle,
                          boxShadow: [
                            BoxShadow(color: morfoWhite, blurRadius: 5)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Lausane650'),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                      decoration: BoxDecoration(
                          color: darkPeriwinkle,
                          boxShadow: [
                            BoxShadow(color: morfoWhite, blurRadius: 5)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Registro',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Lausane650'),
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
