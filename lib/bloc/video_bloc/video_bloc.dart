import 'package:bloc/bloc.dart';
import '../../data_layer/Entities/video.dart';
import '../../data_layer/Repositories/video_repository.dart';

part 'video_bloc_events.dart';
part 'video_bloc_states.dart';


class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository videoRepository = VideoRepository();

  VideoBloc() : super(VideoInitialState()) {
    on<FetchVideotListEvent>((event, emit) async {
      emit(VideoListLoadState());
      try {
        final List<Video> videoLists = await videoRepository.getVideoList(event.subject);
        emit(VideoListFetchedState(videoLists));
      } catch (error) {
        emit(VideoListErrorState());
      }
    });
  }
  }