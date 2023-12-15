import 'dart:developer';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Entities/video.dart';
import '../Services/firebase_service.dart';

class VideoRepository {
  final FirebaseService _firebaseService = FirebaseService();

  Future<List<Video>> getVideoList(String subject) async {
    try {
      final videoLists = await _firebaseService.getVideoList(subject);

      final List<Video> videoModelList = [];

      int len = videoLists.length;

      for (int i = 0; i < len; i++) {
        String? videoId;
        videoId = YoutubePlayer.convertUrlToId(videoLists[i.toString()][1]);
        print(videoId);
        final videoData =
            Video(title: videoLists[i.toString()][0], id: videoId!);
        videoModelList.add(videoData);
      }
      return videoModelList;
    } catch (error) {
      log("Error in VideoRepository: $error");
      return [];
    }
  }
}
