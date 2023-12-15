part of 'package:teach_me/bloc/auth_bloc/auth_bloc.dart';


sealed class AuthEvent {}

final class SignInWithGoogleEvent extends AuthEvent {}

final class CheckAuthStatusEvent extends AuthEvent {}

final class SignOutEvent extends AuthEvent {}
