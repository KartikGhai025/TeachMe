import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/subjectList_bloc/subjectList_bloc.dart';
import '../../bloc/video_bloc/video_bloc.dart';
import '../pages/videoList.dart';

class SubjectList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subjectBloc = BlocProvider.of<SubjectBloc>(context);
    subjectBloc.add(FetchSubjectListEvent('subject','subjectList','subjects'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subjects -',
          style: TextStyle(
            color: Color(0xffAF4748),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        BlocBuilder<SubjectBloc, SubjectState>(builder: (context, state) {
          if (state is SubjectListFetchedState) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.subjectLists.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 80,
                      color: Color(0xffe6ae79),
                      child: Center(
                        child: ListTile(
                          title: Text(
                            state.subjectLists[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Icon(
                            Icons.book,
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
                                    builder: (_) => BlocProvider.value(
                                      value: VideoBloc(),
                                      child: VideoListPage(
                                          subject: state.subjectLists[index]),
                                    )));
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else
            return Container();
        }),
      ],
    );
  }
}
