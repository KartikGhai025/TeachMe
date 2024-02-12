class Student {
  String name;
  //String email;
  //String phone;
  String image_url;
  String description;
  ///String age;
  String studentClass;
  //String city;

  // Constructor
  Student({
    required this.name,
//    required this.email,
  //  required this.phone,
    required this.image_url,
    required this.description,
   // required this.age,
    required this.studentClass,
   // required this.city,
  });

  // Factory method to create a Student instance from a JSON object
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
    //  email: json['email'],
     // phone: json['phone'],
      image_url: json['image_url'],
      description: json['description'],
    //  age: json['age'],
      studentClass: json['class'],
     // city: json['city'],
    );
  }

  // Method to convert a Student instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
     // 'email': email,
     // 'phone': phone,
      'image_url': image_url,
      'description': description,
     // 'age': age,
      'class': studentClass,
      //'city': city,
    };
  }
}
