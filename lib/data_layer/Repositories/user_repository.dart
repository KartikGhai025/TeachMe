import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:teach_me/data_layer/Entities/student.dart';

import '../Entities/user.dart';
import '../Services/firebase_service.dart';

class UserRepository {
  final FirebaseService _firebaseService = FirebaseService();

  Future<UserModel?> signInWithGoogle() async {
    try {
      final User? user = await _firebaseService.signInWithGoogle();

      if (user != null) {
        return UserModel(
          uid: user.uid,
          displayName: user.displayName,
          email: user.email,
        );
      } else {
        return null;
      }
    } catch (error) {
      log("Error in UserRepository: $error");
      return null;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    final currentUser = await _firebaseService.getCurrentUser();
    if (currentUser != null) {
      return UserModel(
          uid: currentUser.uid,
          displayName: currentUser.displayName,
          email: currentUser.email);
    } else
      return null;
  }

  Future<bool> doesUserProfileExists() async {
    return await _firebaseService.doesUserProfileExists();
  }

  Future<Student> getUserProfile() async {
    final data = await _firebaseService.getUserProfile();
    final Student student = Student.fromJson(data);
    return student;
  }

  Future<void> signOut() async {
    await _firebaseService.signOut();
  }

  Future<String> uploadImage(String email, File? image) async {
    return _firebaseService.uploadImage(email, image);
  }

  Future<void> addUserProfile(
      String name,
      String email,
      String phone,
      String image_url,
      String description,
      String age,
      String classValue,
      String city,
      ) async {
    await _firebaseService.addUserProfile(
        name, email, phone, image_url, description, age, classValue, city);
  }
}
