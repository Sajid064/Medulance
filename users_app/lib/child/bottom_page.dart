import 'package:flutter/material.dart';
import 'package:users_app/child/bottom_screens/add_contacts.dart';
import 'package:users_app/child/bottom_screens/chat_page.dart';
import 'package:users_app/child/bottom_screens/child_home_page.dart';
import 'package:users_app/child/bottom_screens/review_page.dart';
import 'package:users_app/pages/home_page.dart';
import 'package:users_app/pages/profile_page.dart';

class BottomPage extends StatefulWidget {
  BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    HomePage(),
    AddContactsPage(),
    ProfilePage(),
    // CheckUserStatusBeforeChatOnProfile(),
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        fixedColor: Colors.pinkAccent,
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: 'Where to?',
              icon: Icon(
                Icons.search,
              )),
          BottomNavigationBarItem(
              label: 'Contacts',
              icon: Icon(
                Icons.contacts,
              )),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.person,
              )),
        ],
      ),
    );
  }
}
