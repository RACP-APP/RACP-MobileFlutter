import 'package:flutter/material.dart';
import '../ui/module_view.dart';
import '../ui/module_list.dart';
import '../ui/landing_page.dart';
import '../ui/welcome.dart';
import '../ui/about_us.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Landing());
      case '/INTRO':
        return MaterialPageRoute(builder: (_) => Welcome());
        case '/AboutUs':
        return MaterialPageRoute(builder: (_) => AboutUs());
      case '/ML':
        return MaterialPageRoute(builder: (_) => ModulesList(args));
      case '/MV':
        // Validation of correct data type

        return MaterialPageRoute(
          builder: (_) => ModulesView(args),
        );

      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.
      //return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
