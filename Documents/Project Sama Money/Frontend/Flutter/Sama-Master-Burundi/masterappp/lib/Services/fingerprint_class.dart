import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrint {
  static Future<bool> authenticateUser() async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();

    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticate(
        biometricOnly: true,
        localizedReason: " ",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (isAuthenticated) {
      return true;
    } else {
      return false;
    }
  }

  // static Future<bool> authenticateUser() async {
  //   final LocalAuthentication _localAuthentication = LocalAuthentication();
  //   bool isAuthenticated = false;
  //   try {
  //     isAuthenticated = await _localAuthentication.authenticate(
  //       localizedReason:
  //           'Scan your fingerprint (or face or whatever) to authenticate',
  //       options: const AuthenticationOptions(
  //         useErrorDialogs: true,
  //         stickyAuth: true,
  //         biometricOnly: true,
  //       ),
  //     );
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }

  //   if (isAuthenticated) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
