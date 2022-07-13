import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welove/main.dart';
import 'package:welove/services/auth_services.dart';
import 'package:welove/services/storage_services.dart';
import 'package:welove/services/user_info_services.dart';

import '../../services/auth_services.dart';

class SayaPage extends StatefulWidget {
  const SayaPage({Key? key}) : super(key: key);

  @override
  State<SayaPage> createState() => SayaPageState();
}

class SayaPageState extends State<SayaPage> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    String? userEmail = FirebaseAuth.instance.currentUser?.email.toString();
    String? userUid = FirebaseAuth.instance.currentUser?.uid.toString();
    // ignore: unused_element
    Future<StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>> namaGambarUser() async {
      return FirebaseFirestore.instance.collection("users").doc(userEmail).snapshots().listen(
            // ignore: avoid_print
            (event) => print("current data: ${event.data()}"),
            // ignore: avoid_print
            onError: (error) => print("Listen failed: $error"),
          );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                // color: Colors.green[600],
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      )
                    ],
                    color: Colors.green[500],
                    borderRadius:
                        const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        // perintah untuk melakukan upload gambar ke firestore storage beserta
                        // hal hal kecil lainnya seperti snackbar untuk notifikasi kegagalan dan keberhasilan
                        onTap: () async {
                          final hasilPilihGambar = await FilePicker.platform.pickFiles(
                              allowMultiple: false, type: FileType.custom, allowedExtensions: ['jpg', 'png']);
                          if (hasilPilihGambar == null) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("tidak ada gambar terpilih")));
                          }
                          final namaGambar = hasilPilihGambar?.files.single.name;
                          final letakGambar = hasilPilihGambar?.files.single.path;
                          if (kDebugMode) {
                            print(namaGambar);
                            print(letakGambar);
                          }
                          if (namaGambar != null && letakGambar != null) {
                            storage
                                .uploadGambar(namaGambar, userEmail!, letakGambar)
                                // ignore: avoid_print
                                .then((value) => print("done uploading"));
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("gagal mengirim gambar")));
                          }
                        },
                        child: StreamBuilder<Object>(
                            stream: FirebaseFirestore.instance.collection("users").doc(userEmail).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Text("Loading");
                              }
                              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                              return FutureBuilder<Object>(
                                  future: storage.urlGambarUser(data["foto profil"], userEmail!),
                                  initialData: null,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                                      return SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: CircularProgressIndicator(color: Colors.green[700]),
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          'https://dagodreampark.co.id/media/k2/items/cache/86e8e67edae9219d12d438efd5f5a939_XL.jpg',
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ),
                                      );
                                    }
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        snapshot.data.toString(),
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      ),
                                    );
                                  });
                            }),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const NamaPengguna(),
                        const WepointPengguna(),
                        Text(
                          userEmail!,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          userUid ?? "tidak ada User",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // list berkelompok untuk pengaturan aplikasi
              // dimulai dari sini
              const KelompokList(
                judulKelompokList: "pengaturan aplikasi",
                judulList: ["pengaturan profil", "pengaturan keamanan", "akun terhubung"],
                routing: ["/pengaturanProfil_page", "/pengaturanKeamanan_page", "/akunTerhubung_page"],
              ),

              const KelompokList(
                judulKelompokList: "pengaturan umum",
                judulList: ["pusat bantuan", "syarat dan ketentuan", "kebijakan privasi", "tentang aplikasi"],
                routing: [
                  "/pusatBantuan_page",
                  "/syaratDanKetentuan_page",
                  "/kebijakanPrivasi_page",
                  "/tentangAplikasi_page"
                ],
              ),
              InkWell(
                  onTap: () async {
                    await context.read<AuthServices>().keluar();
                  },
                  child: const TombolPenting(namaTombol: "keluar")),
            ],
          ),
        ),
      ),
    );
  }
}

// buat tipe data baru bernama "KelompokList"
// yang memuat judul, ke, dan ikon leading
class KelompokList extends StatefulWidget {
  final String judulKelompokList;
  // DaftarJudulKelompokList daftarJudulKelompokList;
  final List<String> judulList;
  final List<String> routing;

  const KelompokList({Key? key, required this.judulKelompokList, required this.judulList, required this.routing})
      : super(key: key);

  @override
  State<KelompokList> createState() => _KelompokListState();
}

class _KelompokListState extends State<KelompokList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 10),
          child: Text(widget.judulKelompokList.toTitleCase()),
        ),
        // ListView.builder(
        //     itemCount: widget.judulList.length,
        //     itemBuilder: (context, index) => ListTile(
        //           title: Text(widget.judulList[index]),
        //           trailing: const Icon(Icons.chevron_right_outlined),
        //         ))
        for (int i = 0; i < widget.judulList.length; i++)
          InkWell(
            onTap: () => Navigator.pushNamed(context, widget.routing[i]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(55),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.judulList[i].toTitleCase(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const Icon(Icons.chevron_right_outlined),
                ],
              ),
            ),
          )
      ]),
    );
  }
}
