import 'dart:io';
import 'package:chatty/shared/network/local/cach_helper.dart';
import 'package:chatty/shared/utils/global.dart';
import 'package:chatty/shared/widgets/loader.dart';
import 'package:chatty/view/screens/OnBoard/onboard_screen.dart';
import 'package:chatty/view/screens/auth/login.dart';
import 'package:chatty/view/screens/lay_out/lay_out.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'controller/provider/auth.dart';



const bool useEmulator = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   if (useEmulator) {
    await _connectToFirebaseEmulator();
  }
  await CachHelper.init();


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProv(),),
  ], child: myApp()
  ));
}
class myApp extends StatelessWidget {

  const myApp();

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context , child) =>  MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        title: 'chatty',
        debugShowCheckedModeBanner: false,
        // builder: (context, child) {
        //   return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1), child: child!);
        // },
        home: (cashHelper.getData(key: 'onBoard')) == null?const OnBoardingScreen() :
        StreamBuilder(
          stream: authChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {

              return const  Loader();

            }
            if (snapshot.hasData) {
              return const LayOut();
            }
            return  const LoginSc();

          },
        ),
      ),
    );
  }
}
Stream<User?> get authChanges => fAuth.authStateChanges();

Future _connectToFirebaseEmulator () async{
  final localHostString = Platform.isAndroid?'10.0.2.2':'localhost';
  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8080',
    sslEnabled: false,
    persistenceEnabled:  false,
  );
  await FirebaseAuth.instance.useAuthEmulator(localHostString,9099);
}

