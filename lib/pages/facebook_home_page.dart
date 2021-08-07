import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:multiple_login/bloc/auth_bloc.dart';
import 'package:multiple_login/pages/login_page.dart';
import 'package:multiple_login/provider/google_signin_provider.dart';
import 'package:provider/provider.dart';

class FacebookLoggedInWidget extends StatefulWidget {
  @override
  _FacebookLoggedInWidgetState createState() => _FacebookLoggedInWidgetState();
}

class _FacebookLoggedInWidgetState extends State<FacebookLoggedInWidget> {
  bool textPressed = false;
  late StreamSubscription<User?> homeStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    homeStateSubscription = authBloc.currentUser.listen((fbuser) {
      if (fbuser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    homeStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text('Logout'),
            onPressed: () {
              authBloc.logoutFB();
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Color(0xFF141221),
        child: StreamBuilder<User?>(
            stream: authBloc.currentUser,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello! ${snapshot.data!.displayName}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 32),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        '${snapshot.data!.photoURL.toString()}?width=500&height500'),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    child: textPressed
                        ? Text(
                            'Email: ${snapshot.data!.email}',
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
              );
            }),
      ),
    );
  }
}
