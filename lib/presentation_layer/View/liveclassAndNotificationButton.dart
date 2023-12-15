import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teach_me/bloc/subjectList_bloc/subjectList_bloc.dart';
import 'package:teach_me/data_layer/Entities/video.dart';
import 'package:teach_me/presentation_layer/pages/notificationPage.dart';
import 'package:teach_me/presentation_layer/pages/videoPage.dart';

class LiveclassAndNotification extends StatelessWidget {
  const LiveclassAndNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {


                final Video video= Video(title: 'Live', id: 'P9C25Un7xaM');

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPlayer(video: video,)));
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffFFE3D3), // Background color
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Shadow color
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.live_tv,
                      size: 30,
                      color: Color(0xff81ae7e),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Liveclass',
                      style: TextStyle(
                        color: Color(0xffAF4748),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create:(context) =>  SubjectBloc(),
                            child: NotificationPage())));
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffFFE3D3), // Background color
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Shadow color
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: Color(0xff81ae7e),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Notifications',
                      style: TextStyle(
                        color: Color(0xffAF4748),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}