import 'package:bloc/bloc.dart';
import '../../data_layer/Entities/student.dart';
import '../../data_layer/Repositories/user_repository.dart';
part 'userProfile_events.dart';
part 'userProfile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository = UserRepository();

  ProfileBloc() : super(ProfileInitialState()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileLoadState());
      try {
        final Student student = await userRepository.getUserProfile();
        emit(ProfileFetchedState(student));
      } catch (error) {
        emit(SubjectListErrorState());
      }
    });
  }
}
