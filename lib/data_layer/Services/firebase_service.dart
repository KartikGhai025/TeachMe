import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    } catch (error) {
      log("Error signing in with Google: $error");
      return null;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final currentuser = await _auth.currentUser;

      return currentuser;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<List<dynamic>> getSubjectLists(String collection,String id,String field) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection(collection).doc(id).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        final subjectList = data[field];

        return subjectList;
      } else
        return [];
    } catch (error) {
      log("Error fetching subject lists: $error");
      return [];
    }
  }

  Future<bool> doesUserProfileExists() async {
    try {
      String id = _auth.currentUser!.uid;

      final DocumentSnapshot<Map<String, dynamic>> userProfile =
          await _firestore.collection('userProfile').doc(id).get();
      if (userProfile.exists) {
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      String id = _auth.currentUser!.uid;
      final DocumentSnapshot<Map<String, dynamic>> userProfile =
          await _firestore.collection('userProfile').doc(id).get();
      if (userProfile.exists) {
        Map<String, dynamic> data = userProfile.data() as Map<String, dynamic>;
        return data;
      } else
        return {};
    } catch (e) {
      log(e.toString());
      return {};
    }
  }

  Future<String> uploadImage(String id, File? image) async {
    try {
      if (image != null) {
        final storageRef =
            FirebaseStorage.instance.ref().child('users/$id.jpg');
        await storageRef.putFile(image);

        return await storageRef.getDownloadURL();
      } else {
        return ''; // Return an empty string if no image is provided
      }
    } catch (error) {
      log('Error uploading image: $error');
      return '';
      // throw Exception('Error uploading image');
    }
  }

  Future<void> addUserProfile(
    String name,
  //  String email,
   // String phone,
    String imageUrl,
    String description,
   // String age,
    String classValue,
 //   String city,
  ) async {
    try {
      String id = _auth.currentUser!.uid;

      await _firestore.collection('userProfile').doc(id).set({
        'name': name,
      //  'email': email,
      //  'phone': phone,
        'image_url': imageUrl,
        'description': description,
       // 'age': age,
        'class': classValue,
      //  'city': city,
      });
    } catch (error) {
      log('Error adding user profile: $error');
    }
  }

  Future<Map<String, dynamic>> getVideoList(String subject) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> videos =
          await _firestore.collection('videos').doc(subject).get();
      if (videos.exists) {
        Map<String, dynamic> data = videos.data() as Map<String, dynamic>;
        print(data);

        return data['videos'];
      } else
        return {};
    } catch (e) {
      log(e.toString());
      return {};
    }
  }
}
