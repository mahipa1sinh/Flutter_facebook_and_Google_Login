import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:multiple_login/provider/facebook_auth_provider.dart';

class AuthBloc {
  final authService = AuthService();
  final fb = FacebookLogin();

  Stream<User?> get currentUser => authService.currentUser;

  loginWithFacebook() async {
    print('Starting Facebook Login................................');

    final res = await fb.logIn(["public_profile", "email"]);

    switch (res.status) {
      case FacebookLoginStatus.loggedIn:
        print(
            "It's Working....................,.,.,,.,,,.,.,.,.,.,.,.,..,.,.,.whooopa");
        // Get Token
        final FacebookAccessToken fbToken = res.accessToken;
        //Auth Cred.
        final AuthCredential credential =
            FacebookAuthProvider.credential(fbToken.token);
        // USER cred. to sign in with firebase
        final result = await authService.signInWithCredential(credential);

        print('${result.user!.displayName} is IN .......,.,..,.,.,,');

        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Canceled..................,.,.,.,.,.,.,,.,.,');
        break;
      case FacebookLoginStatus.error:
        print('Error.............');
        break;
    }
  }

  logoutFB() {
    authService.logout();
  }
}
