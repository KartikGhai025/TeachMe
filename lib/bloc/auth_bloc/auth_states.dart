part of 'package:teach_me/bloc/auth_bloc/auth_bloc.dart';


sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthenticatedState extends AuthState {
  final UserModel user;

  AuthenticatedState(this.user);
}

final class ProfileExistsState extends AuthState{

}
final class ProfileNotExistsState extends AuthState{}
final class AuthLoading extends AuthState{}
final class UnauthenticatedState extends AuthState {}