import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/padded_button.dart';
import 'package:flash_chat/managers/auth_manager.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    if (AuthManager().isSignedIn) {
      Navigator.pushNamed(context, kRouteChat);
    }

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: 1,
    );
    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    controller.addListener(() {
      setState(() {});
    });

    // AuthManager().listenForRedirects();
    checkForRedirect();
  }

  void checkForRedirect() {
    print("Checking for redirect in welcome screen");
    if (AuthManager().isSignedIn) {
      print("Redirect without listener");
      Navigator.pushNamed(context, kRouteChat);
      return;
    } else {
      print("No user now, use the listener");
    }

    AuthManager().setListener(() {
      if (AuthManager().isSignedIn) {
        print("Redirect with listener");
        Navigator.pushNamed(context, kRouteChat);
        AuthManager().stopListening();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red.withOpacity(controller.value),
      // backgroundColor: Colors.white,
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: kTagLogo,
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                    // height: animation.value * 100,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  // controller.value.toStringAsFixed(1),
                  text: ["Flash Chat"],
                  speed: Duration(milliseconds: 250),
                  isRepeatingAnimation: false,
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                // Text(
                //   // controller.value.toStringAsFixed(1),
                //   "Flash Chat",
                //   style: TextStyle(
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            PaddedButton(
              text: "Log in",
              onPressedAction: () {
                //Go to login screen.
                AuthManager().stopListening();
                Navigator.pushNamed(context, kRouteLogin);
              },
              color: Colors.lightBlueAccent,
            ),
            PaddedButton(
              text: "Register",
              onPressedAction: () {
                //Go to registration screen.
                AuthManager().stopListening();
                Navigator.pushNamed(context, kRouteRegistration);
              },
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
