part of 'package:teach_me/bloc/subjectList_bloc/subjectList_bloc.dart';

sealed class SubjectEvent {}

class FetchSubjectListEvent extends SubjectEvent {
 final String collection;
  final String id;
  final String field;

  FetchSubjectListEvent(this.collection, this.id, this.field);
}