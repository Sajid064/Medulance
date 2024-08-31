import 'package:admin_web/dashboard/side_navigation_drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDpHdt-2kEC6FkVvpyM97-bDUgv9hl_k5k",
          authDomain: "medulance-3.firebaseapp.com",
          databaseURL: "https://medulance-3-default-rtdb.firebaseio.com",
          projectId: "medulance-3",
          storageBucket: "medulance-3.appspot.com",
          messagingSenderId: "593455084856",
          appId: "1:593455084856:web:9b95a80523109cfb93bdcd",
          measurementId: "G-5C5X80WJBX"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: SideNavigationDrawer(),
    );
  }
}
