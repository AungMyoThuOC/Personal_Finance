
// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

final LocalAuthentication bioauth = LocalAuthentication();

class BiometricHelper {
  Future<bool> hasEnrolledBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await bioauth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      return authenticate();
    }
    return false;
  }

  Future<bool> authenticate() async {
    final bool didAuthenticate = await bioauth.authenticate(
        localizedReason: 'Please authenticate to show your account balance',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Biometric authentication required!',
            cancelButton: 'No thanks',
          ),
          IOSAuthMessages(
            cancelButton: 'No thanks',
          ),
        ]);
    print(didAuthenticate);
    return didAuthenticate;
  }
}
