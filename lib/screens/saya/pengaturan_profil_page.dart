import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nomorHpController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<String?> userUid = context.read<AuthServices>().dapatkanUid();
    Future<String?> useremail = context.read<AuthServices>().dapatkanEmail();

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
              InputPenting(judulInput: "nama", namaController: namaController),
              InputPenting(judulInput: "nomor Hp", namaController: nomorHpController),
              InputPenting(judulInput: "kota", namaController: kotaController),
              InputPenting(judulInput: "jenis kelamin", namaController: jenisKelaminController),
              InkWell(
                onTap: () async {
                  db.collection("users").doc(await useremail).set({
                    "uid": await userUid,
                    "nama": namaController.text.trim(),
                    "hp": nomorHpController.text.trim(),
                    "kota": kotaController.text.trim(),
                    "jenis kelamin": jenisKelaminController.text.trim()
                  }, SetOptions(merge: true));
                },
                child: TombolPenting(
                  namaTombol: "update data",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
