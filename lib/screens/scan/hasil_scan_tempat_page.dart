// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
    String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
    // perintah mendapatkan posisi dari user, dan melakukan perhitungan apakah user ada pada lokasi
    // atau user berada pada tempat lain. sehingga
    // tida ada kecuragan dalam memasukkan tempat sampah
    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      }
      return await Geolocator.getCurrentPosition();
    }

    Future<String> jarakUserKeTempatSampah(double latitudefirestore, double longitudefirestore) async {
      Position posisi = await _determinePosition();
      double latitude = posisi.latitude;
      double longitude = posisi.longitude;
      double distanceInMeters = Geolocator.distanceBetween(latitude, longitude, latitudefirestore, longitudefirestore);
      if (distanceInMeters > 15) {
        return "tidak di lokasi";
      } else {
        return "latitude anda: $latitude dan longitude anda: $longitude sehingga jarak anda dengan mesin $distanceInMeters";
      }
    }

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
                      initialData: null,
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
                        return FutureBuilder<Object>(
                            future: jarakUserKeTempatSampah(data['latitude'], data['longitude']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                    width: 150,
                                    height: 150,
                                    margin: EdgeInsets.fromLTRB(20, 200, 20, 10),
                                    child: const CircularProgressIndicator());
                              }
                              if (snapshot.data == null || snapshot.hasError) {
                                return Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.fromLTRB(20, 200, 20, 10),
                                        child: Text("maaf, sepertinya ada masalah dengan gps anda".toTitleCase(),
                                            textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline1)),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                                      child: Text(
                                          "pastikan anda menyalakan gps agar kami dapat mengetahiu posisi anda. apakah anda benar2 anda di lokasi tempat dimana mesin kami berada atau tidak",
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                );
                              }
                              if (snapshot.data == "tidak di lokasi") {
                                return Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.fromLTRB(20, 200, 20, 10),
                                        child: Text("maaf, sepertinya ada tidak ada di lokasi mesin kami".toTitleCase(),
                                            textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline1)),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                                      child: Text(
                                          "pastikan anda berada disekitar mesin kami, dan pastikan gps anda disetel kedalam mode akurasi tinggi. karena kami mendeteksi anda berada jauh dari mesin kami",
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                );
                              }
                              // jika user berada dalam jangkauan, maka tulis ready ke tempat sampah
                              // agar tempat sampah tidak disalahgunakan\
                              // if (snapshot.data != "tidak di lokasi") {
                              FirebaseFirestore.instance.collection("tempat_sampah").doc(widget.dataQrCode).set(
                                {"is ready": true, "email user": userEmail},
                                SetOptions(merge: true),
                              );
                              return Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(20, 200, 20, 10),
                                      child: Text("Selamat Telah Menemukan Salahsatu Mesin Kami".toTitleCase(),
                                          textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline1)),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                                    child: Text(
                                        "anda telah menemukan mesin kami yang bernama ${data['nama']} yang berlokasi di ${data['lokasi']} berlatitude ${data['latitude']} dan berlongitude ${data['longitude']}. sedangkan ${snapshot.data} anda semakin dekat dengan tujuan. \n\n selanjutnya, scan sampah yang ingin anda masukkan kedalam tempat sampah",
                                        textAlign: TextAlign.center),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/scan_sampah');
                                    },
                                    child: TombolPenting(
                                      namaTombol: "scan sampah",
                                    ),
                                  )
                                ],
                              );
                              // }
                            });
                      }),
                ],
              ),
            )),
      ),
    );
  }
}
