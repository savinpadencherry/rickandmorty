// ignore_for_file: body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:story/constants/constants.dart';
import 'dart:developer' as dev;

class AuthRepository {
  String? _codephone;
  String? _verificationId;
  String? _verificationFailedMessage;
  int? _resendingtoken;
  String? _errorMessage;

  FirebaseAuth _auth = FirebaseAuth.instance;

  String? get verificationId {
    return _verificationId;
  }

  String? get verificationfailedMessage {
    return _verificationFailedMessage;
  }

  String? get codePhone {
    return _codephone;
  }

  String? get errorMessage {
    return _errorMessage;
  }

  int? get resendingToken {
    return _resendingtoken;
  }

  Future<String?> sendCodeToPhone(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential authCredential) {},
      verificationFailed: (FirebaseAuthException authException) {
        _verificationFailedMessage = authException.message;
      },
      codeSent: (verificationid, resendingToken) {
        _codephone = Constants.sentCode;
        _verificationId = verificationid;
        _resendingtoken = resendingToken;
        dev.log('$verificationId',
            name: 'checking for the verification id from codesent function');
        dev.log('$_verificationId',
            name: 'My verificationId is being given its value or not');
      },
      codeAutoRetrievalTimeout: (verifcationid) {},
      phoneNumber: phoneNumber,
    );
  }

  PhoneAuthCredential phoneAuthCredentialFunction(
      {required String verificationIdToken, required String otp}) {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationIdToken, smsCode: otp);
    return phoneAuthCredential;
  }

  Future<bool?> signInwithphoneCredentials(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      dev.log('$authCredential',
          name: 'Checking for authcredential in authrepository');
      if (authCredential.user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
    }
  }
}
