import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teach_me/data_layer/Repositories/video_repository.dart';
import 'package:teach_me/presentation_layer/app_router.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/createProfile_bloc/createProfile_bloc.dart';
import 'bloc/subjectList_bloc/subjectList_bloc.dart';
import 'bloc/userProfile_bloc/userProfile_bloc.dart';
import 'bloc/video_bloc/video_bloc.dart';
import 'data_layer/Entities/video.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<SubjectBloc>(
            create: (context) => SubjectBloc(),
          ),
          BlocProvider<CreateProfileBloc>(
            create: (context) => CreateProfileBloc(),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(),
          ),
          BlocProvider<VideoBloc>(
            create: (context) => VideoBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TeachMe',
          onGenerateRoute: AppRouter.onGenerateRoute,
        //  home: AddData(),
        ));
  }
}

class AddData extends StatelessWidget {
  const AddData({super.key});

  void checkfun()async{
    VideoRepository videosRepo= VideoRepository();
    final List<Video> videos= await videosRepo.getVideoList('English');


    print(videos);
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async {
           checkfun();
          },
          child: Text('Add '),
        ),
      ),
    );
  }
}


/*
try {
await FirebaseFirestore.instance
    .collection('videos')
    .doc('Science')
    .set({
'videos': {
'0': [
'Chemical Reactions and Equations',
'https://www.youtube.com/watch?v=43G7DnxgJCI'
],
'1': [
'Control and Coordination',
'https://www.youtube.com/watch?v=6GQqmzap6Aw'
],
'2': [
'Electricity One Shot Revision',
'https://www.youtube.com/watch?v=XfehrU2qLW8'
],

}
});
} catch (error) {
print('Error adding user profile: $error');
}*/