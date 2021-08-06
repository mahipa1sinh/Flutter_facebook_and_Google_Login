import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiple_login/components/login_fields.dart';
import 'package:multiple_login/provider/google_signin_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 20,
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
