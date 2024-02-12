part of 'package:teach_me/bloc/userProfile_bloc/userProfile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

final class ProfileLoadState extends ProfileState {}

final class ProfileFetchedState extends ProfileState {
  final Student student;

  ProfileFetchedState(this.student);
}

final class ProfileErrorState extends ProfileState {}
