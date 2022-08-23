// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String authStatus;
  final String? phoneNumber;
  final String? code;
  final String? verificationId;
  final PhoneAuthCredential? phoneAuthCredential;
  const AuthState({
    required this.authStatus,
    required this.phoneNumber,
    required this.code,
    this.verificationId,
    this.phoneAuthCredential,
  });

  factory AuthState.intial() {
    return const AuthState(
        authStatus: Constants.authUnknown, code: "", phoneNumber: "");
  }

  @override
  List<Object?> get props {
    return [
      authStatus,
      phoneNumber,
      code,
      verificationId,
      phoneAuthCredential,
    ];
  }

  @override
  bool get stringify => true;

  AuthState copyWith({
    String? authStatus,
    String? phoneNumber,
    String? code,
    String? verificationId,
    PhoneAuthCredential? phoneAuthCredential,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      code: code ?? this.code,
      verificationId: verificationId ?? this.verificationId,
      phoneAuthCredential: phoneAuthCredential ?? this.phoneAuthCredential,
    );
  }
}
