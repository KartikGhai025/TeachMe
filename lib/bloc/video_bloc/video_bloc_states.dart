part of 'package:teach_me/bloc/video_bloc/video_bloc.dart';



sealed class VideoState {}

final class VideoInitialState extends VideoState {}

final class VideoListLoadState extends VideoState {}

final class VideoListFetchedState extends VideoState {
  final List<Video> videoLists;

  VideoListFetchedState(this.videoLists);
}

final class VideoListErrorState extends VideoState {}
