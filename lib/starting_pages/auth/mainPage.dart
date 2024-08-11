/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:morflutter/starting_pages/ui/intro_screens/onboardScreen.dart';
import 'package:morflutter/starting_pages/auth/loginPage.dart';
import 'package:morflutter/starting_pages/auth/registerPage.dart';
import 'package:morflutter/starting_pages/ui/sbk101/about_sbk101.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isFirstTime = true;
  bool _isShowingLoginPage = true; // To toggle between login and register pages

  @override
  void initState() {
    super.initState();
    _checkIfFirstTime();
  }

  Future<void> _checkIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstTime = prefs.getBool('isFirstTime') ?? true;
    });
  }

  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }

  void _toggleToRegisterPage() {
    setState(() {
      _isShowingLoginPage = false;
    });
  }

  void _toggleToLoginPage() {
    setState(() {
      _isShowingLoginPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstTime) {
      return OnboardingScreen(onFinish: _completeOnboarding);
    } else {
      return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AboutSbk101();
          } else {
            return _isShowingLoginPage
                ? MorfoLoginPage(showRegisterPage: _toggleToRegisterPage)
                : RegisterPage(showLoginPage: _toggleToLoginPage);
          }
        },
      );
    }
  }
}
*/

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:morflutter/starting_pages/ui/intro_screens/onboardScreen.dart';
import 'package:morflutter/starting_pages/auth/loginPage.dart';
import 'package:morflutter/starting_pages/auth/registerPage.dart';
import 'package:morflutter/starting_pages/ui/sbk101/about_sbk101.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isShowingLoginPage = true; // To toggle between login and register pages
  bool _isOnboardingCompleted = false; // To track if onboarding is completed

  void _toggleToRegisterPage() {
    setState(() {
      _isShowingLoginPage = false;
    });
  }

  void _toggleToLoginPage() {
    setState(() {
      _isShowingLoginPage = true;
    });
  }

  void _completeOnboarding() {
    setState(() {
      _isOnboardingCompleted = true; // Onboarding is completed
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOnboardingCompleted) {
      return OnboardingScreen(onFinish: _completeOnboarding);
    } else {
      return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return _isShowingLoginPage
                  ? MorfoLoginPage(showRegisterPage: _toggleToRegisterPage)
                  : RegisterPage(showLoginPage: _toggleToLoginPage);
            } else {
              return AboutSbk101(); // User is authenticated, show the About page
            }
          } else {
            // Show a loading spinner while waiting for the connection state
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    }
  }
}
