import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screeen.dart'; // Fixed typo
import 'screens/home_screen.dart';
import 'screens/task_screen.dart';

void main() {
  runApp(LifeSyncApp());
}

class LifeSyncApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeSync - AI-Powered Life Organizer',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/task': (context) => TaskInputScreen(), // ✅ Added Task Screen route
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return _customPageRoute(LoginScreen(), const Offset(1.0, 0.0));
          case '/signup':
            return _customPageRoute(SignupScreen(), const Offset(0.0, 1.0));
          case '/home':
            return _customPageRoute(HomeScreen(), const Offset(0.0, 1.0));
          case '/task': // ✅ Added Task Screen route in `onGenerateRoute`
            return _customPageRoute(TaskInputScreen(), const Offset(1.0, 0.0));
          default:
            return null;
        }
      },
    );
  }

  PageRouteBuilder _customPageRoute(Widget page, Offset beginOffset) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        var tween =
        Tween(begin: beginOffset, end: Offset.zero).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
