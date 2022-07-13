import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/foundation.dart';

class Storage {
  FirebaseStorage storage = FirebaseStorage.instance;
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();

  Future<void> uploadGambar(String namaGambar, String emailUser, String letakGambar) async {
    File file = File(letakGambar);
    try {
      await storage.ref("/users/$emailUser/$namaGambar").putFile(file);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userEmail)
          .set({"foto profil": namaGambar}, SetOptions(merge: true));
    } on firebase_core.FirebaseException catch (error) {
      if (kDebugMode) {
        print(error.message.toString());
      }
    }
  }

  Future<String> urlGambarUser(String namaGambar, String emailUser) async {
    String urlGambar = await storage.ref('/users/$emailUser/$namaGambar').getDownloadURL();
    return urlGambar;
  }
}
