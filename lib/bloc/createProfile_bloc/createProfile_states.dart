part of 'package:teach_me/bloc/createProfile_bloc/createProfile_bloc.dart';

sealed class UserProfileState {}

class UserProfileInitialState extends UserProfileState {}

class UserProfileLoadingState extends UserProfileState {}

class UserProfileSuccessState extends UserProfileState {}

class UserProfileErrorState extends UserProfileState {
  final String error;

  UserProfileErrorState(this.error);
}
