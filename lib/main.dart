import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/managers/auth_manager.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';

// Pattern from https://firebase.flutter.dev/docs/overview

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize
      await Firebase.initializeApp();
      setState(() {
        print("finished initializing");
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        print("error");
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      theme: ThemeData.light(),
      routes: {
        kRouteLogin: (context) => LoginScreen(),
        kRouteWelcome: (context) => WelcomeScreen(),
        kRouteRegistration: (context) => RegistrationScreen(),
        kRouteChat: (context) => ChatScreen(),
      },
      initialRoute: kRouteWelcome,
    );

    if (_error) {
      return materialApp;
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return materialApp;
    }

    AuthManager().beginListening();
    return materialApp;
  }
}
