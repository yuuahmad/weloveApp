import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:welove/main.dart';

Future<String> dapatkanDataUser() async {
  List<String> data = [];
  await FirebaseFirestore.instance.collection("users").get().then((event) {
    for (var doc in event.docs) {
      data.add("${doc.id} => ${doc.data()}");
    }
  });
  return data.toString();
}

Future<String> dapatkanDataSemuaUser() async {
  String data = "";
  await FirebaseFirestore.instance.collection("users").get().then((value) => data = value.toString());
  return data;
}

class NamaPengguna extends StatefulWidget {
  const NamaPengguna({Key? key}) : super(key: key);
  @override
  State<NamaPengguna> createState() => _NamaPenggunaState();
}

class _NamaPenggunaState extends State<NamaPengguna> {
  @override
  Widget build(BuildContext context) {
    String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(userEmail).snapshots(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        // jika dokumen ada dan berhasil didapatkan, tampilkan ini
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Text(
          "${data["nama"]}".toTitleCase(),
          style: Theme.of(context).textTheme.headline3,
        );
      },
    );
  }
}

class WepointPengguna extends StatefulWidget {
  const WepointPengguna({Key? key}) : super(key: key);
  @override
  State<WepointPengguna> createState() => _WepointPenggunaState();
}

class _WepointPenggunaState extends State<WepointPengguna> {
  @override
  Widget build(BuildContext context) {
    String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(userEmail).snapshots(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        // jika dokumen ada dan berhasil didapatkan, tampilkan ini
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Text(
          "${data["wepoint"]} Wepoint".toTitleCase(),
          style: Theme.of(context).textTheme.headline3,
        );
      },
    );
  }
}
