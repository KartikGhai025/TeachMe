import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../View/studentProfileView.dart';
import '../View/subjectList.dart';
import '../View/liveclassAndNotificationButton.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
 //   log('current state of authbloc is' + authBloc.state.toString());


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(0xffAF4748),
      ),
      body: Container(
        color: Color(0xffAF4748),
        height: double.maxFinite,
        child: Stack(
          children: [
            Column(
              children: [
                StudentProfileView(),
                MaterialButton(
                  onPressed: () {
                    authBloc.add(SignOutEvent());
                  },
                  child: BlocConsumer<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xffFFE3D3), // Background color
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Color(0xff81ae7e),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  color: Color(0xffAF4748),
                                  // fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    listener: (context, state) {
                      if (state is UnauthenticatedState) {
                        Navigator.pushReplacementNamed(context, '/');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Signed Out'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
            DraggableScrollableSheet(
              maxChildSize: .78,
              initialChildSize: .75,
              minChildSize: .2,
              builder: (context, scrollController) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 19,
                      right: 19,
                      //    top: 16,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Color(0xfff8e8d8),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          LiveclassAndNotification(),
                          SizedBox(
                            height: 10,
                          ),
                          SubjectList(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}






