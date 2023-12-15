import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teach_me/bloc/auth_bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(CheckAuthStatusEvent());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(0xfff8e8d8),
      ),
      body: Container(
        height: double.maxFinite,
        child: Stack(
          children: [
            SizedBox(
              height: size.height,
              child: Image.asset(
                'assets/loginpage_bg.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Column(
              children: [
                Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/studentgraphic2.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
            Column(
              children: [
                Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    'assets/studentgraphic.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Image.asset(
                      'assets/logo.png',
                      // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Text(
                    'TeachMe',
                    style: GoogleFonts.permanentMarker(
                      color: Color(0xffAF4748),
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  InkWell(
                    onTap: () {
                      authBloc.add(SignInWithGoogleEvent());
                    },
                    child: BlocConsumer<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container(
                              height: 35,
                              //  padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  //   color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 1, color: Colors.blue)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'G',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      height: double.maxFinite,
                                      color: Colors.blue,
                                      child: Center(
                                          child: Text(
                                        '  Sign In with Google ',
                                        style: TextStyle(color: Colors.white),
                                      ))),
                                ],
                              ));
                        }
                      },
                      listener: (context, state) {
                        if (state is ProfileExistsState) {
                          Navigator.pushReplacementNamed(context, '/homePage');
                        }
                        if (state is ProfileNotExistsState) {
                          Navigator.pushReplacementNamed(
                              context, '/createProfilePage');
                        }

                        if (state is UnauthenticatedState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('failed to login! \nContact Admin'),
                              duration: Duration(milliseconds: 300),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
