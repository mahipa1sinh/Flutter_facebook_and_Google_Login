import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multiple_login/components/google_logged_in_widget.dart';
import 'package:multiple_login/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Processing..');
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return LoggedInWidget();
          } else if (snapshot.hasError) {
            print('Error!!!');
            return Center(child: Text('Something Went Wrong!'));
          } else {
            print('Returned to Login Page');
            return LoginPage();
          }
        },
      ),
    );
  }
}
