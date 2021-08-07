import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_login/provider/google_signin_provider.dart';
import 'package:provider/provider.dart';

class LoggedInWidget extends StatefulWidget {
  @override
  _LoggedInWidgetState createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {
  bool textPressed = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text('Logout'),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSigninProvider>(context, listen: false);

              provider.googleLogout();
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Color(0xFF141221),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello! ${user.displayName}',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 32),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            SizedBox(height: 10),
            TextButton(
              child: textPressed
                  ? Text(
                      'Email: ${user.email}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  : Text(
                      'Tap Here To reveal Email Id',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
              onPressed: () {
                setState(() {
                  textPressed = true;
                });
              },
              onLongPress: () {
                setState(() {
                  textPressed = false;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
