// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welove/main.dart';
import 'package:welove/screens/mainMenu/main_page.dart';
import 'package:welove/screens/scan/scan_tempat.dart';

class MasukkanSampahPage extends StatefulWidget {
  const MasukkanSampahPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MasukkanSampahPage> createState() => _MasukkanSampahPageState();
}

class _MasukkanSampahPageState extends State<MasukkanSampahPage> {
  @override
  Widget build(BuildContext context) {
    final simpanDataTempat = Provider.of<SimpanDataTempat>(context);
    // print(simpanDataTempat.result!.code);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 200, 20, 10),
                      child: Text("menunggu anda memasukkan sampah".toTitleCase(),
                          textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline1)),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                    child: Text(
                        "masukkan sampah anda kedalam tempat sampah. sehingga anda menjadi penyelamat bumi sejati :)",
                        textAlign: TextAlign.center),
                  ),
                  Text(simpanDataTempat.result!.code.toString()),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("tempat_sampah")
                        .doc(simpanDataTempat.result!.code.toString().trim())
                        .snapshots(),
                    initialData: null,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                        return SizedBox(width: 100, height: 100, child: const CircularProgressIndicator());
                      }
                      // jika dokumen ada dan berhasil didapatkan, tampilkan ini
                      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                      // namaController = TextEditingController(text: "${data["nama"]}".toTitleCase());
                      return data["is masuk"] == false
                          ? SizedBox(
                              width: 100,
                              height: 100,
                              child: const CircularProgressIndicator(),
                            )
                          : Column(
                              children: [
                                Text("sampah berhasil masuk"),
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (context) => MainPage()),
                                          (Route<dynamic> route) => false);
                                      FirebaseFirestore.instance
                                          .collection("tempat_sampah")
                                          .doc(simpanDataTempat.result!.code.toString())
                                          .set({
                                        "is ready": false,
                                        "sensor ready": false,
                                        "is masuk": false,
                                        "email user": ""
                                      }, SetOptions(merge: true));
                                    },
                                    child: TombolPenting(
                                      namaTombol: "kembali ke home",
                                    ))
                              ],
                            );
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
