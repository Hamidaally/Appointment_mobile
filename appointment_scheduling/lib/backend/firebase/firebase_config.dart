import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDoBK8-xKDFDcy0EEB3HYSKlgV3BseDhSo",
            authDomain: "appointment-scheduling-h0t6af.firebaseapp.com",
            projectId: "appointment-scheduling-h0t6af",
            storageBucket: "appointment-scheduling-h0t6af.appspot.com",
            messagingSenderId: "1098062153648",
            appId: "1:1098062153648:web:7b05105de3745633fa3875"));
  } else {
    await Firebase.initializeApp();
  }
}
