import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/subjectList_bloc/subjectList_bloc.dart';

class NotificationPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final subjectBloc = BlocProvider.of<SubjectBloc>(context);
    subjectBloc.add(FetchSubjectListEvent('notification','notification','notifications'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffAF4748),
        title: Text('Notifications'),
      ),
      body: Scaffold(
        body: Container(
            //height: double.maxFinite,
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/loginpage_bg.png',
                  // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                  fit: BoxFit.cover,
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
                        const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xffe6ae79),
                                border: Border.all(
                                    color: Color(0xfff8e8d8)
                                )
                            ),
                            height: 100,
                           // color: Color(0xffe6ae79),
                            child: Center(
                              child: ListTile(
                                title: Text(
                                  state.subjectLists[index],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: Icon(
                                  Icons.notifications,
                                  color: Color(0xffAF4748),
                                ),

                                onTap: () {
                                  _showDescriptionPopup(context,state.subjectLists[index]);
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
            ])),
      ),
    );
  }

  void _showDescriptionPopup(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffAF4748),
          title: Text(
            'Notification',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(description, style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
