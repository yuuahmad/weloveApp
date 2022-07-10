import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welove/main.dart';
import 'package:welove/screens/login/masuk.dart';
import 'package:welove/services/auth_services.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({Key? key}) : super(key: key);

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final TextEditingController namacontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController ulangiPasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              height: 250,
              width: 250,
              'https://welove.web.id//assets/images/welove-1-removebg-preview-208x208.png',
              loadingBuilder: ((context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : LinearProgressIndicator(
                        color: Colors.green,
                        value: loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!.toDouble());
              }),
            ),
            Text(
              "daftar aplikasi".toTitleCase(),
              style: TextStyle(fontSize: 30, color: Colors.green[700]),
            ),
            InputPenting(judulInput: "Nama", namaController: namacontroller),
            InputPenting(judulInput: "Email", namaController: emailcontroller),
            InputPenting(judulInput: "Password", namaController: passwordcontroller),
            InputPenting(judulInput: "Ulangi Password", namaController: ulangiPasswordcontroller),
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                await context
                    .read<AuthServices>()
                    .daftar(email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());
                FirebaseFirestore.instance.collection("users").doc(emailcontroller.text.trim()).set({
                  "email": emailcontroller.text.trim(),
                  "password": passwordcontroller.text.trim(),
                  "nama": namacontroller.text.trim(),
                  "wepoint": 0
                }, SetOptions(merge: true));
              },
              child: const TombolPenting(
                namaTombol: "daftar",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "sudah punya akun?",
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      " masuk",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    ));
  }
}
