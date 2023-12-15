import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teach_me/presentation_layer/pages/homePage.dart';
import 'package:teach_me/presentation_layer/pages/loginPage.dart';
import 'package:teach_me/presentation_layer/pages/notificationPage.dart';
import 'package:teach_me/presentation_layer/pages/create_profile.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/homePage':
        return MaterialPageRoute(builder: (_) => HomePage());

      case '/createProfilePage':
        return MaterialPageRoute(builder: (_) => CreateProfile());

      case '/notificationPage':
        return MaterialPageRoute(builder: (_) => NotificationPage());

      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
