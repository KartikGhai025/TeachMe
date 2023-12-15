part of 'package:teach_me/bloc/subjectList_bloc/subjectList_bloc.dart';

sealed class SubjectState {}

final class SubjectInitialState extends SubjectState {}

final class SubjectListLoadState extends SubjectState {}

final class SubjectListFetchedState extends SubjectState {
  final List<String> subjectLists;

  SubjectListFetchedState(this.subjectLists);
}

final class SubjectListErrorState extends SubjectState {}
