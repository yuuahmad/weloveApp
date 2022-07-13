import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:welove/services/user_info_services.dart';

class LainnyaPage extends StatefulWidget {
  const LainnyaPage({Key? key}) : super(key: key);

  @override
  State<LainnyaPage> createState() => _LainnyaPageState();
}

class _LainnyaPageState extends State<LainnyaPage> {
  final docRef = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    String? userEmail = FirebaseAuth.instance.currentUser?.email.toString();
    Future<StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>> namaGambarUser() async {
      return FirebaseFirestore.instance.collection("users").doc(userEmail!).snapshots().listen(
            // ignore: avoid_print
            (event) => print("current data: ${event.data()}"),
            // ignore: avoid_print
            onError: (error) => print("Listen failed: $error"),
          );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("LainnyaPage"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: docRef.doc("ahmadyusufmaulana0@gmail.com").get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                // jika ada error tampilkan data ini
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }
                // jika dokumen tidak ditemukan tampilkan ini
                if (snapshot.hasData && !snapshot.data!.exists) {
                  return const Text("Document does not exist");
                }
                // jika dokumen ada dan berhasil didapatkan, tampilkan ini
                if (snapshot.connectionState == ConnectionState.done) {
                  // Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Text("data : ${snapshot.data!.data().toString()}");
                }
                // jika tidak semuanya, tampilkan loadingProgress
                return const Text("loading");
              },
            ),
            // buat percobaan baru lagi karena saya masih penasaran dengan data yang saya miliki namun tidak bisa saya lihat
            // ini adalah tampian data dari fungsi yang saya buat sendiri
            const SizedBox(
              height: 100,
            ),
            FutureBuilder(
                future: dapatkanDataUser(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text("data userrr: ${snapshot.data!.toString()}");
                  }
                  return const Text("loading");
                })),
            const SizedBox(height: 100),

            // ini adalah contoh dari flutter firebase documentation
            // berisi semua data dari collection user
            const UserInformation(),

            // current user information only
            const SizedBox(
              height: 100,
            ),
            Text(FirebaseAuth.instance.currentUser!.uid.toString()),
            const SizedBox(height: 100),
            Container(
              color: Colors.amber,
              child: const NamaPengguna(),
            ),
            const Text("data"),

            // dari atas yang saya buat sendiri untuk mendapatkan gambar user
            Text(namaGambarUser().toString())
          ],
        ),
      ),
    );
  }
}

// nyolong dari flutterfire
class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Column(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Text(data.toString());
          }).toList(),
        );
        // return Text(snapshot.data!.docs.toString());
      },
    );
  }
}
