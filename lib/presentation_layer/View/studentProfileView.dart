import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/userProfile_bloc/userProfile_bloc.dart';

class StudentProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(FetchProfileEvent());

    return Container(
      padding: EdgeInsets.all(15),
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileFetchedState) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    foregroundImage: NetworkImage(state.student.image_url),
                    radius: 80,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                state.student.name,
                                style: GoogleFonts.shadowsIntoLight(
                                  color: Color(0xfff9be0c),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                                textAlign: TextAlign.end,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              ' (${state.student.age})',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.shadowsIntoLight(
                                fontSize: 25,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffe6ae79),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          state.student.studentClass,
                          textAlign: TextAlign.end,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xfff8e8d8),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          state.student.email,
                          textAlign: TextAlign.end,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xfff8e8d8),
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                'City: ${state.student.city}',
                                textAlign: TextAlign.end,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xfff8e8d8),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                state.student.phone,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xfff8e8d8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ListView(
                    children: [
                      Text(
                        state.student.description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          shadows: [
                            Shadow(
                              color: Color(0xff6b8458),
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Color(0xfff8e8d8),
                        ),
                        // maxLines: 6,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else
          return Container();
      }),
    );
  }
}