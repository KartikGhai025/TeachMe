import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teach_me/bloc/video_bloc/video_bloc.dart';
import 'package:teach_me/presentation_layer/pages/videoPage.dart';
import '../../data_layer/Entities/video.dart';

class VideoListPage extends StatefulWidget {
  final String subject;

  const VideoListPage({super.key, required this.subject});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final videoBloc = context.read<VideoBloc>();

    if (!videoBloc.videoStates.containsKey(widget.subject)) {
      videoBloc.add(FetchVideotListEvent(subject: widget.subject));


    }
  }

  @override
  Widget build(BuildContext context) {
   // final videoBloc = BlocProvider.of<VideoBloc>(context);
    //videoBloc.add(FetchVideotListEvent(subject:widget.subject));

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xffFFE3D3),
        backgroundColor: Color(0xffAF4748),
        title: Text(widget.subject),
      ),
      body: Scaffold(
        body: Container(
            height: double.maxFinite,
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/loginpage_bg.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
                if (state is VideoListFetchedState) {
                  final videoBloc = context.read<VideoBloc>();

                  if (videoBloc.videoStates.containsKey(widget.subject)) {
                    List<Video> videoLists= videoBloc.videoStates[widget.subject]!;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: videoLists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xffe6ae79),
                                border: Border.all(color: Color(0xfff8e8d8))),
                            height: 80,
                            // color: Color(0xffe6ae79),
                            child: Center(
                              child: ListTile(
                                title: Text(
                                  videoLists[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: Icon(
                                  Icons.play_circle,
                                  color: Color(0xffAF4748),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xffAF4748),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VideoPlayer(
                                                video: videoLists[index],
                                              )));
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );}
                }

                  return Container();
              } ),
            ])),
      ),
    );
  }
}
