import 'package:cached_network_image/cached_network_image.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/global/global_var.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:restart_app/restart_app.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:users_app/methods/common_methods.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController carTextEditingController = TextEditingController();

  setDriverInfo() {
    setState(() {
      nameTextEditingController.text = userName;
      phoneTextEditingController.text = userPhone;
      emailTextEditingController.text =
          FirebaseAuth.instance.currentUser!.email.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setDriverInfo();
    getUserInfoAndCheckBlockStatus();
  }

  CommonMethods cMethods = CommonMethods();

  getUserInfoAndCheckBlockStatus() async {
    DatabaseReference usersRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    await usersRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        if ((snap.snapshot.value as Map)["blockStatus"] == "no") {
          setState(() {
            userName = (snap.snapshot.value as Map)["name"];
            userPhone = (snap.snapshot.value as Map)["phone"];
          });
        } else {
          FirebaseAuth.instance.signOut();

          Navigator.push(
              context, MaterialPageRoute(builder: (c) => LoginScreen()));

          cMethods.displaySnackBar(
              "you are blocked. Contact admin: alizeb875@gmail.com", context);
        }
      } else {
        FirebaseAuth.instance.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  File? _image = userPhoto;

  Future getImage() async {
    var pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        userPhoto = _image;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'User Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? CircleAvatar(
                    radius: 80,
                    backgroundImage: CachedNetworkImageProvider(
                      'https://example.com/default_profile_image.jpg',
                    ),
                  )
                : CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(_image!),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImage,
              child: Text(
                'Upload Image',
                style: TextStyle(color: Colors.pinkAccent, fontSize: 18),
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            //driver name
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 8),
              child: TextField(
                controller: nameTextEditingController,
                textAlign: TextAlign.center,
                enabled: false,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 4,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            //driver phone
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 4),
              child: TextField(
                controller: phoneTextEditingController,
                textAlign: TextAlign.center,
                enabled: false,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.phone_android_outlined,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            //driver email
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 4),
              child: TextField(
                controller: emailTextEditingController,
                textAlign: TextAlign.center,
                enabled: false,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //logout btn
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 16)),
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   body: Center(

    //     child: SingleChildScrollView(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           //image
    //           Scaffold(
    //             // width: 180,
    //             // height: 180,
    //             // decoration: BoxDecoration(
    //             //     shape: BoxShape.circle,
    //             //     color: Colors.grey,
    //             //     image: DecorationImage(
    //             //       fit: BoxFit.fitHeight,
    //             //       image: NetworkImage(
    //             //         userPhoto,
    //             //       ),
    //             //     )),

    //             body: Center(
    //               child: _image == null
    //                   ? Text('No image selected.')
    //                   : Image.file(_image!),
    //             ),
    //             floatingActionButton: Column(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 FloatingActionButton(
    //                   onPressed: getImage,
    //                   tooltip: 'Pick Image',
    //                   child: Icon(Icons.add_a_photo),
    //                 ),
    //                 SizedBox(height: 16),
    //                 FloatingActionButton(
    //                   onPressed: uploadImage,
    //                   tooltip: 'Upload Image',
    //                   child: Icon(Icons.file_upload),
    //                 ),
    //               ],
    //             ),
    //           ),

    //           const SizedBox(
    //             height: 16,
    //           ),

    //           //driver name
    //           Padding(
    //             padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 8),
    //             child: TextField(
    //               controller: nameTextEditingController,
    //               textAlign: TextAlign.center,
    //               enabled: false,
    //               style: const TextStyle(fontSize: 16, color: Colors.black),
    //               decoration: const InputDecoration(
    //                 filled: true,
    //                 fillColor: Colors.white24,
    //                 border: OutlineInputBorder(
    //                   borderSide: BorderSide(
    //                     color: Colors.black,
    //                     width: 2,
    //                   ),
    //                 ),
    //                 prefixIcon: Icon(
    //                   Icons.person,
    //                   color: Colors.black,
    //                 ),
    //               ),
    //             ),
    //           ),

    //           //driver phone
    //           Padding(
    //             padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 4),
    //             child: TextField(
    //               controller: phoneTextEditingController,
    //               textAlign: TextAlign.center,
    //               enabled: false,
    //               style: const TextStyle(fontSize: 16, color: Colors.black),
    //               decoration: const InputDecoration(
    //                 filled: true,
    //                 fillColor: Colors.white24,
    //                 border: OutlineInputBorder(
    //                   borderSide: BorderSide(
    //                     color: Colors.black,
    //                     width: 2,
    //                   ),
    //                 ),
    //                 prefixIcon: Icon(
    //                   Icons.phone_android_outlined,
    //                   color: Colors.black,
    //                 ),
    //               ),
    //             ),
    //           ),

    //           //driver email
    //           Padding(
    //             padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 4),
    //             child: TextField(
    //               controller: emailTextEditingController,
    //               textAlign: TextAlign.center,
    //               enabled: false,
    //               style: const TextStyle(fontSize: 16, color: Colors.black),
    //               decoration: const InputDecoration(
    //                 filled: true,
    //                 fillColor: Colors.white24,
    //                 border: OutlineInputBorder(
    //                   borderSide: BorderSide(
    //                     color: Colors.black,
    //                     width: 2,
    //                   ),
    //                 ),
    //                 prefixIcon: Icon(
    //                   Icons.email,
    //                   color: Colors.black,
    //                 ),
    //               ),
    //             ),
    //           ),

    //           const SizedBox(
    //             height: 12,
    //           ),

    //           //logout btn
    //           ElevatedButton(
    //             onPressed: () {
    //               FirebaseAuth.instance.signOut();
    //               Navigator.push(context,
    //                   MaterialPageRoute(builder: (c) => LoginScreen()));
    //             },
    //             style: ElevatedButton.styleFrom(
    //                 backgroundColor: Colors.pink,
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 80, vertical: 18)),
    //             child: const Text("Logout"),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
