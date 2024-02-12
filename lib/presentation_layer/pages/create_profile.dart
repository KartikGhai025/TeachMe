import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../bloc/createProfile_bloc/createProfile_bloc.dart';
import '../../data_layer/Services/firebase_service.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
 // late String _email;
 // late String _phone;
  late String _description;
 // late String _age;
  late String _class;
 // late String _city;
  File? _image;

  Future<void> _uploadData() async {
    if(_image == null){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Select Image')));
    }
    if (_formKey.currentState!.validate()) {
      context.read<CreateProfileBloc>().add(
            UserProfileSubmitEvent(
              name: _name,
           //   email: _email,
            //  phone: _phone,
              description: _description,
            //  age: _age,
              classValue: _class,
            //  city: _city,
              image: _image,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFE3D3),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Create Profile'),
        backgroundColor: Color(0xffAF4748),
        actions: [
          IconButton(
              onPressed: () async {
                final FirebaseService _firebaseService = FirebaseService();
                await _firebaseService.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: Icon(Icons.logout)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: BlocConsumer<CreateProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileSuccessState) {
            Navigator.pushReplacementNamed(context, '/homePage');

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Successfully Created Profile')));
          } else if (state is UserProfileErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is UserProfileLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final res = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        setState(() {
                          _image = File(res!.path);
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffAF4748)),
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.fitHeight,
                                  )
                                : Icon(
                                    Icons.camera_alt,
                                    size: 50,
                                    color: Color(0xffFFE3D3),
                                  )),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: (value) => _name = value,
                    ),
                   /* TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (value) => _email = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phone'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onChanged: (value) => _phone = value,
                    ),*/
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onChanged: (value) => _description = value,
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(labelText: 'Age'),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your age';
                    //     }
                    //     return null;
                    //   },
                    //   onChanged: (value) => _age = value,
                    // ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Class'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your class';
                        }
                        return null;
                      },
                      onChanged: (value) => _class = value,
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(labelText: 'City'),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your city';
                    //     }
                    //     return null;
                    //   },
                    //   onChanged: (value) => _city = value,
                    // ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Color(0xffAF4748))),
                      child: TextButton(
                        onPressed: _uploadData,
                        child: Text(
                          'Upload Profile',
                          style:
                              TextStyle(color: Color(0xffAF4748), fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
