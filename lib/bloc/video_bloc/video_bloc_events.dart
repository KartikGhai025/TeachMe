part of 'package:teach_me/bloc/video_bloc/video_bloc.dart';

sealed class VideoEvent {}

class FetchVideotListEvent extends VideoEvent {
  final String subject;

  FetchVideotListEvent(this.subject);


}