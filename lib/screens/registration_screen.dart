import 'package:flash_chat/components/padded_button.dart';
import 'package:flash_chat/managers/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = "";
  String password = "";
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: kTagLogo,
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldEmailDecoration,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldPasswordDecoration,
              ),
              SizedBox(
                height: 24.0,
              ),
              PaddedButton(
                  text: 'Register',
                  onPressedAction: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    //Implement registration functionality.
                    print(email);
                    print(password);
                    final newUser =
                        await AuthManager().createUser(email, password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, kRouteChat);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                  color: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
