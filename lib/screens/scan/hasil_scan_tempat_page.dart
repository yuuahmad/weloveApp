// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:welove/main.dart';

class HasilScanTempatPage extends StatefulWidget {
  final String dataQrCode;
  const HasilScanTempatPage({Key? key, required this.dataQrCode}) : super(key: key);

  @override
  State<HasilScanTempatPage> createState() => _HasilScanTempatPageState();
}

class _HasilScanTempatPageState extends State<HasilScanTempatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance.collection('tempat_sampah').doc(widget.dataQrCode).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text("Loading");
                        }
                        if (snapshot.data.data() == null || snapshot.hasError) {
                          return Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(20, 200, 20, 10),
                                  child: Text("maaf, sepertinya anda salah scan barcode".toTitleCase(),
                                      textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline1)),
                              Container(
                                margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                                child: Text(
                                    "sepertinya barcode yang anda scan bukanlah barcode salahsatu mesin kami. kembali ke bagian scan untuk melakukan scan ulang, atau kunjungi halaman maps mesin kami agar anda dapat mengetahui dimana saja mesin kami berada",
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          );
                        }
                        // jika dokumen ada dan berhasil didapatkan, tampilkan ini
                        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                        return Column(
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(20, 200, 20, 10),
                                child: Text("Selamat Telah Menemukan Salahsatu Mesin Kami".toTitleCase(),
                                    textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline1)),
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                              child: Text(
                                  "anda telah menemukan mesin kami yang bernama ${data['nama']} yang berlokasi di ${data['lokasi']}. anda semakin dekat dengan tujuan. \n\n selanjutnya, scan sampah yang ingin anda masukkan kedalam tempat sampah",
                                  textAlign: TextAlign.center),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/hasil_scan_tempat_page');
                              },
                              child: TombolPenting(
                                namaTombol: "Siap",
                              ),
                            )
                          ],
                        );
                      }),
                ],
              ),
            )),
      ),
    );
  }
}
