import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoggedInWidget extends StatelessWidget {
  const LoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text('Logout'),
            onPressed: () {},
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
              'Hello!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
