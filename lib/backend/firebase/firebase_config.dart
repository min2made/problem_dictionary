import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyALRaqLSa4foD8_lmN_19cpwry4cbAziPU",
            authDomain: "problem-dictionary-v5resv.firebaseapp.com",
            projectId: "problem-dictionary-v5resv",
            storageBucket: "problem-dictionary-v5resv.appspot.com",
            messagingSenderId: "109715317835",
            appId: "1:109715317835:web:16ef5782b4623c37aa59ce"));
  } else {
    await Firebase.initializeApp();
  }
}
