import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welove/services/auth_services.dart';

class LainnyaPage extends StatefulWidget {
  const LainnyaPage({Key? key}) : super(key: key);

  @override
  State<LainnyaPage> createState() => _LainnyaPageState();
}

class _LainnyaPageState extends State<LainnyaPage> {
  final docRef = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    Future<String?> userEmail = context.read<AuthServices>().dapatkanEmail();
    return Scaffold(
      appBar: AppBar(
        title: Text("LainnyaPage"),
      ),
      body: Center(
          child: FutureBuilder(
        future: docRef.doc("ahmadyusufmaulana0@gmail.com").get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          // jika ada error tampilkan data ini
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          // jika dokumen tidak ditemukan tampilkan ini
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }
          // jika dokumen ada dan berhasil didapatkan, tampilkan ini
          if (snapshot.connectionState == ConnectionState.done) {
            // Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Text("data : ${snapshot.data!.data().toString()}");
          }
          // jika tidak semuanya, tampilkan loadingProgress
          return Text("loading");
        },
      )),
    );
  }
}
