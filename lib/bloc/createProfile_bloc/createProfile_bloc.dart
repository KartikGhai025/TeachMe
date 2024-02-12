import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data_layer/Repositories/user_repository.dart';
import '../auth_bloc/auth_bloc.dart';
part 'createProfile_events.dart';
part 'createProfile_states.dart';

class CreateProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository userRepository = UserRepository();
  final AuthBloc authBloc = AuthBloc();
  CreateProfileBloc() : super(UserProfileInitialState()) {
    on<UserProfileSubmitEvent>((event, emit) async {
      emit(UserProfileLoadingState());

      try {
        final imageUrl =
            await userRepository.uploadImage(FirebaseAuth.instance.currentUser!.uid, event.image);

        await userRepository.addUserProfile(
          event.name,
       //   event.email,
      //    event.phone,
          imageUrl,
          event.description,
       //   event.age,
          event.classValue,
        //  event.city
        );

        emit(UserProfileSuccessState());
      } catch (error) {
        emit(UserProfileErrorState("Error submitting profile: $error"));
      }
    });
  }
}
