// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:story/constants/constants.dart';
import 'package:story/core/repository/authrepository.dart';
import 'dart:developer' as dev;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({
    required this.authRepository,
  }) : super(AuthState.intial()) {
    on<AuthEvent>((event, emit) {});

    on<AuthPhoneCode>((event, emit) async {
      emit(state.copyWith(authStatus: Constants.authLoading));
      try {
        final String? verificationId =
            await authRepository.sendCodeToPhone(event.phoneNumber);
        dev.log('$verificationId',
            name: 'VerficationId in authPhoneEvent(AuthBloc)');
        emit(
          state.copyWith(
              authStatus: Constants.authSuccessSendingCode,
              phoneNumber: event.phoneNumber,
              verificationId: verificationId),
        );
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(authStatus: e.message));
        dev.log('${e.message}', name: 'Error message');
      }
    });

    on<VerifyCode>((event, emit) {
      emit(state.copyWith(authStatus: Constants.authLoading));
      try {
        final PhoneAuthCredential phoneAuthCredential =
            authRepository.phoneAuthCredentialFunction(
                verificationIdToken: event.verficationId, otp: event.code);
        dev.log('$phoneAuthCredential',
            name: 'checking for phoneauthcredential in authbloc');
        emit(state.copyWith(
            authStatus: Constants.codeVerified,
            phoneAuthCredential: phoneAuthCredential,
            verificationId: event.verficationId));
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(authStatus: e.message));
        dev.log('${e.message}', name: 'Error message');
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(state.copyWith(authStatus: Constants.authLoading));
      try {
        final bool? doesUserExist = await authRepository
            .signInwithphoneCredentials(event.phoneAuthCredential);
        emit(state.copyWith(authStatus: Constants.authAuthenticated));
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(authStatus: e.message));
        dev.log('${e.message}', name: 'Error message');
      }
    });
  }
}
