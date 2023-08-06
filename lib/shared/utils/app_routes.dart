import 'package:flutter/material.dart';
import '../../view/screens/OnBoard/onboard_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginScreen = 'login';
  static const String OtpSc = 'otp';
  static const String homeScreen = 'Home';
  static const String undefinedRoute = 'undefined';



}

class AppRoutes {
  AppRoutes({this.curve=Curves.ease,this.X=0,this.Y=0.2});
  Curve? curve;
       double? X,Y;

   Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.initialRoute:
        return createRoute(widget: const OnBoardingScreen(), curve: curve, X: X!,Y: Y!);

      // case Routes.loginScreen:
      //   return const LoginScreen();
      //   case Routes.OtpSc:
      //  final verificationId = settings.arguments as String;
      //   return OtpSc(
      //     VerificationId: verificationId,
      //   );

      // case Routes.homeScreen:
      //   return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return undefinedRoute();
    }
  }
   static Route  undefinedRoute() {
    return MaterialPageRoute(builder: (context) => Scaffold(
      body: Center(
        child: Text('Wrong path..............'),
      ),
    ),);
  }
}

createRoute({
  required Widget widget,
  required var curve,
  required double X,Y,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(X,Y);
      const end = Offset.zero;

      var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}