import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welove/main.dart';
import 'package:welove/screens/login/masuk.dart';

import '../../services/auth_services.dart';

class PengaturanProfilPage extends StatefulWidget {
  const PengaturanProfilPage({Key? key}) : super(key: key);

  @override
  State<PengaturanProfilPage> createState() => _PengaturanProfilPageState();
}

class _PengaturanProfilPageState extends State<PengaturanProfilPage> {
  var db = FirebaseFirestore.instance;
  TextEditingController namaController = TextEditingController();
  TextEditingController nomorHpController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<String?> userUid = context.read<AuthServices>().dapatkanUid();
    String userEmail = FirebaseAuth.instance.currentUser!.email.toString();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "pengaturan profil".toTitleCase(),
                style: TextStyle(fontSize: 30, color: Colors.green[700]),
              ),
              StreamBuilder(
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
                  namaController = TextEditingController(text: "${data["nama"]}".toTitleCase());
                  nomorHpController = TextEditingController(text: "${data["hp"]}".toTitleCase());
                  kotaController = TextEditingController(text: "${data["kota"]}".toTitleCase());
                  jenisKelaminController = TextEditingController(text: "${data["jenis kelamin"]}".toTitleCase());

                  return Column(
                    children: [
                      InputPenting(judulInput: "nama", namaController: namaController),
                      InputPenting(
                        judulInput: "nomor Hp",
                        namaController: nomorHpController,
                      ),
                      InputPenting(
                        judulInput: "kota",
                        namaController: kotaController,
                      ),
                      InputPenting(judulInput: "jenis kelamin", namaController: jenisKelaminController),
                    ],
                  );
                },
              ),
              InkWell(
                onTap: () async {
                  db.collection("users").doc(userEmail).set({
                    "uid": await userUid,
                    "nama": namaController.text.trim(),
                    "hp": nomorHpController.text.trim(),
                    "kota": kotaController.text.trim(),
                    "jenis kelamin": jenisKelaminController.text.trim()
                  }, SetOptions(merge: true));
                },
                child: const TombolPenting(
                  namaTombol: "update data",
                ),
              ),
              // percobaan mendapatkan data
              // HintTextInjector()
            ],
          ),
        ),
      ),
    );
  }
}

// widget untuk memasukkan hint text pada input field atau **text field
class HintTextInjector extends StatefulWidget {
  const HintTextInjector({Key? key}) : super(key: key);
  @override
  State<HintTextInjector> createState() => _HintTextInjectorState();
}

class _HintTextInjectorState extends State<HintTextInjector> {
  var db = FirebaseFirestore.instance;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nomorHpController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
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
        return Column(
          children: [
            InputPenting(
              judulInput: "nama",
              namaController: TextEditingController(text: "${data["nama"]}".toTitleCase()),
            ),
            InputPenting(
              judulInput: "nomor Hp",
              namaController: TextEditingController(text: "${data["hp"]}".toTitleCase()),
            ),
            InputPenting(
              judulInput: "kota",
              namaController: TextEditingController(text: "${data["kota"]}".toTitleCase()),
            ),
          ],
        );
      },
    );
  }
}
