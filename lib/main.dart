import 'package:flutter/material.dart';
import 'package:multiple_login/bloc/auth_bloc.dart';
import 'package:multiple_login/components/google_logged_in_widget.dart';
import 'package:multiple_login/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multiple_login/provider/google_signin_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (context) {
    //     GoogleSigninProvider();
    //     AuthBloc();
    //   },
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSigninProvider()),
        Provider(create: (context) => AuthBloc())
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF141221), // vulcan color
          accentColor: Color(0xFF604FEF), // royal Blue color
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          'Loggedin': (context) => LoggedInWidget(),
        },
      ),
    );
  }
}
