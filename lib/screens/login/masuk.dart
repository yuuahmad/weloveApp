import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welove/main.dart';
import 'package:welove/services/auth_services.dart';

class MasukPage extends StatefulWidget {
  const MasukPage({Key? key}) : super(key: key);

  @override
  State<MasukPage> createState() => _MasukPageState();
}

class _MasukPageState extends State<MasukPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

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
              "masuk aplikasi".toTitleCase(),
              style: TextStyle(fontSize: 30, color: Colors.green[700]),
            ),
            InputPenting(judulInput: "Email", namaController: emailcontroller),
            InputPenting(judulInput: "Password", namaController: passwordcontroller),
            InkWell(
              onTap: () {
                context
                    .read<AuthServices>()
                    .masuk(email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());
              },
              child: TombolPenting(
                namaTombol: "masuk",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "belum punya akun?",
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/daftar_page");
                    },
                    child: const Text(
                      " daftar",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class InputPenting extends StatefulWidget {
  final String judulInput;
  final TextEditingController namaController;
  final String hintText;
  const InputPenting(
      {Key? key, required this.judulInput, required this.namaController, this.hintText = "Masukkan Data"})
      : super(key: key);

  @override
  State<InputPenting> createState() => _InputPentingState();
}

class _InputPentingState extends State<InputPenting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 55 / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55),
        color: Colors.grey[300],
      ),
      child: TextField(
        controller: widget.namaController,
        decoration: InputDecoration(
          labelText: widget.judulInput,
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
