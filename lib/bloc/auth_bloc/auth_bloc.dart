import 'dart:developer';

import '../../data_layer/Entities/user.dart';
import '../../data_layer/Repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
part 'auth_states.dart';
part 'auth_events.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository = UserRepository();

  AuthBloc() : super(AuthInitialState()) {

    on<CheckAuthStatusEvent>((event,emit)async{
     // log('checking user');
      emit(AuthLoading());
      final currentUser = await userRepository.getCurrentUser();
      if (currentUser != null){
        final bool userExists= await userRepository.doesUserProfileExists();
        if(userExists)
        {
         // final Student student= await userRepository.getUserProfile();
          emit(ProfileExistsState());
        }
        else{
          emit(ProfileNotExistsState());
        }
       // emit(AuthenticatedState(currentUser));
     // log('user exist');
      }
      else{
        emit(AuthInitialState());
      //  log('no user found');
      }
    });

    on<SignInWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      final currentUser = await userRepository.signInWithGoogle();
      if (currentUser != null){
        final bool userExists= await userRepository.doesUserProfileExists();
        if(userExists)
        {
      //    final Student student= await userRepository.getUserProfile();
          emit(ProfileExistsState());
        }
        else{
          emit(ProfileNotExistsState());
        }

    //    log('user exist');
      }
      else{
        emit(AuthInitialState());
     //   log('no user found');
      }


    });

    on<SignOutEvent>((event,emit)async{
      emit(AuthLoading());
      await userRepository.signOut();
      emit(UnauthenticatedState());
    });


  }
}

/*

on<SignInWithGoogleEvent>((event, emit) async {
emit(AuthLoading());
final user = await userRepository.signInWithGoogle();
if (user != null){
emit(AuthenticatedState(user));

}
else{
emit(UnauthenticatedState());
}


});*/
