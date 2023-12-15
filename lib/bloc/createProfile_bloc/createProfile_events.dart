part of 'package:teach_me/bloc/createProfile_bloc/createProfile_bloc.dart';


abstract class UserProfileEvent {}

class UserProfileSubmitEvent extends UserProfileEvent {
  final String name;
  final String email;
  final String phone;
  final String description;
  final String age;
  final String classValue;
  final String city;
  final File? image;

  UserProfileSubmitEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.description,
    required this.age,
    required this.classValue,
    required this.city,
    this.image,
  });
}
