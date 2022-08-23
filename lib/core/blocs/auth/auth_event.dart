// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthPhoneCode extends AuthEvent {
  final String phoneNumber;

  const AuthPhoneCode({required this.phoneNumber});
  @override
  List<Object> get props => [phoneNumber];
}

class VerifyCode extends AuthEvent {
  final String code;
  final String verficationId;
  const VerifyCode({
    required this.code,
    required this.verficationId,
  });
  @override
  List<Object> get props => [code, verficationId];
}

class SignUpEvent extends AuthEvent {
  final PhoneAuthCredential phoneAuthCredential;
  const SignUpEvent({
    required this.phoneAuthCredential,
  });
  @override
  List<Object> get props => [phoneAuthCredential];
}
