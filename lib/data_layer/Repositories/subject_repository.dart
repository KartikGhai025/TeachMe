import 'dart:developer';

import '../Services/firebase_service.dart';

class SubjectRepository {
  final FirebaseService _firebaseService = FirebaseService();

  Future<List<String>> getSubjectLists(String collection,String id,String subject) async {
    try {
      final subjectLists =
          await _firebaseService.getSubjectLists(collection,id,subject);
      final List<String> stringList =
          subjectLists.map((e) => e as String).toList();
      return stringList;
    } catch (error) {
      log("Error in SubjectRepository: $error");
      return [];
    }
  }
}
