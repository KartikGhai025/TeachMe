import 'package:bloc/bloc.dart';
import '../../data_layer/Repositories/subject_repository.dart';
part 'subjectList_events.dart';
part 'subjectList_states.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectRepository subjectRepository = SubjectRepository();

  SubjectBloc() : super(SubjectInitialState()) {
    on<FetchSubjectListEvent>((event, emit) async {
      emit(SubjectListLoadState());
      try {
        final List<String> subjectLists = await subjectRepository
            .getSubjectLists(event.collection, event.id, event.field);
        emit(SubjectListFetchedState(subjectLists));
      } catch (error) {
        emit(SubjectListErrorState());
      }
    });
  }
}
