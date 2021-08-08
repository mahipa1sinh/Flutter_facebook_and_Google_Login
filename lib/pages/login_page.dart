import 'dart:async';
import 'dart:convert';
// import 'package:http/http.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiple_login/bloc/auth_bloc.dart';
import 'package:multiple_login/components/login_fields.dart';
import 'package:multiple_login/pages/facebook_home_page.dart';
import 'package:multiple_login/pages/home_page.dart';
import 'package:multiple_login/provider/google_signin_provider.dart';
// import 'package:multiple_login/provider/facebook_signin_provider.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn = false;
  Map userObj = {};
  late StreamSubscription<User?> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbuser) {
      if (fbuser != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => FacebookLoggedInWidget()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF141221),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 180),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.teal.shade700,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            LoginField(),
            SizedBox(
              height: 38,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(300, 50),
              ),
              icon: FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              label: Text(
                'Sign Up With Google',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSigninProvider>(context, listen: false);
                provider.googleLogin();
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext) => HomePage()));
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(300, 50),
              ),
              icon: FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
              label: Text(
                'Sign Up With Facebook',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                authBloc.loginWithFacebook();
              },
            ),
          ],
        ),
      ),
    );
  }
}
