// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welove/main.dart';
import 'package:welove/screens/scan/scan_tempat.dart';

class HasilScanSampahPage extends StatefulWidget {
  final String dataQrCode;
  const HasilScanSampahPage({Key? key, required this.dataQrCode}) : super(key: key);

  @override
  State<HasilScanSampahPage> createState() => HasilScanSampahPageState();
}

class HasilScanSampahPageState extends State<HasilScanSampahPage> {
  @override
  Widget build(BuildContext context) {
    // String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
    final simpanDataTempat = Provider.of<SimpanDataTempat>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance.collection('barcode_data').doc(widget.dataQrCode).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                              width: 150,
                              height: 150,
                              margin: EdgeInsets.fromLTRB(20, 200, 20, 10),
                              child: const CircularProgressIndicator());
                        }
                        if (snapshot.data.data() == null || snapshot.hasError) {
                          return Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(20, 200, 20, 10),
                                  child: Text("maaf, sepertinya barcode sampah tidak ditemukan".toTitleCase(),
                                      textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline1)),
                              Container(
                                margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                                child: Text(
                                    "sampah yang anda masukkan dengan kode ${widget.dataQrCode} belum terdaftar kedalam database kami. \n\n screenshot halaman ini dan segera adukan ke kami melalui halaman pengaduan agar kami dapat mendaftarkan sampah anda :)",
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          );
                        }
                        // jika dokumen ada dan berhasil didapatkan, tampilkan ini
                        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                        FirebaseFirestore.instance
                            .collection("tempat_sampah")
                            .doc(simpanDataTempat.result!.code.toString())
                            .set({"sensor ready": true}, SetOptions(merge: true));
                        return Column(
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(20, 200, 20, 10),
                                child: Text("selamat sampah anda valid dan ada dalam database kami".toTitleCase(),
                                    textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline1)),
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                              child: Text(
                                  "sampah anda dengan kode ${widget.dataQrCode} ada dalam database kami. rincian sampah anda adalah sebagai berikut: \n\n nama sampah: ${data["nama sampah"]} \n brand: ${data["brand"]} \n tipe: ${data["tipe"]} \n welove point: ${data["welove point"]} \n berat kosong: ${data["berat kosong"]}",
                                  textAlign: TextAlign.center),
                            ),
                            Text(simpanDataTempat.result!.code.toString()),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/masukkan_sampah_page');
                              },
                              child: TombolPenting(
                                namaTombol: "masukkan sampah",
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
