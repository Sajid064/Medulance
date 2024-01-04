import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userName = "";
String userPhone = "";
String userID = FirebaseAuth.instance.currentUser!.uid;

String googleMapKey = "AIzaSyAxC7FP5pQEpYR2ZK1-7jmK0FnpyDImXo4";
String serverKeyFCM =
    "key=AAAAiiyt9Tg:APA91bFAUZcMkXylYW4dBsegLPTiWP9NJvO7HU5SjwmuqpLZkZuQHrzxjV4iDqW0gtMZbYcYffvoTVV2WhQz5HN3dOstK1iM9q2y9QD0Hs9xZgtwHluJ-_FTPEMzyhIJTQg7LoDBNY0S";

const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);
