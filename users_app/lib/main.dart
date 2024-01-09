import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_app/db/share_pref.dart';
// import 'package:women_safety_app/child/bottom_screens/child_home_page.dart';
import 'package:users_app/child/child_login_screen.dart';
import 'package:users_app/parent/parent_home_screen.dart';
import 'package:users_app/utils/constants.dart';
import 'package:users_app/utils/flutter_background_services.dart';
import 'child/bottom_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:users_app/appInfo/app_info.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/authentication/signup_screen.dart';
import 'package:users_app/firebase_options.dart';
import 'package:users_app/pages/home_page.dart';

final navigatorkey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Permission.locationWhenInUse.isDenied.then((valueOfPermission) {
    if (valueOfPermission) {
      Permission.locationWhenInUse.request();
    }
  });


  await Permission.locationWhenInUse.isDenied.then((valueOfPermission) {
    if (valueOfPermission) {
      Permission.locationWhenInUse.request();
    }
  });

  await MySharedPrefference.init();
  await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // scaffoldMessengerKey: navigatorkey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.firaSansTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.blue,
        ),
        home: BottomPage());
  }
}

// class CheckAuth extends StatelessWidget {
//   // const CheckAuth({Key? key}) : super(key: key);

//   checkData() {
//     if (MySharedPrefference.getUserType() == 'parent') {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
