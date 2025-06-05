import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConfig {
  static const FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyBoA7d6bTqhZif73P7_Pslj9rH2CXSz5SM",
    authDomain: "challengeiii-a9728.firebaseapp.com",
    projectId: "challengeiii-a9728",
    storageBucket: "challengeiii-a9728.appspot.com",
    messagingSenderId: "803438859340",
    appId: "1:803438859340:web:e41266b9c4d406844310e9",
    measurementId: "G-37GSP48X60",
  );

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: firebaseOptions,
    );
  }

  static final FirebaseAuth auth = FirebaseAuth.instance;
} 