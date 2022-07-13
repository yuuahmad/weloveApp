import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:welove/main.dart';
import 'package:welove/screens/mainMenu/berita/berita_detail_page.dart';
import 'package:welove/screens/mainMenu/main_page.dart';
import 'package:welove/services/storage_services.dart';

import '../../services/user_info_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    String? userEmail = FirebaseAuth.instance.currentUser?.email.toString();
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // bagian pertama dari layar home_page
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
                  // padding ini ingin saya ganti menjadi gambar yang bisa dilihat
                  StreamBuilder<Object>(
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
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(color: Colors.green[700]),
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      'https://dagodreampark.co.id/media/k2/items/cache/86e8e67edae9219d12d438efd5f5a939_XL.jpg',
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                margin: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    snapshot.data.toString(),
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              );
                            });
                      }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [NamaPengguna(), WepointPengguna()],
                  )
                ],
              ),
            ),
            // bagian kedua homepage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KirimTerimaRiwayat(
                  ikonkartu: Icons.outbox_outlined,
                  katakartu: "Kirim",
                  routing: "/kirim_page",
                ),
                KirimTerimaRiwayat(
                  ikonkartu: Icons.inbox_outlined,
                  katakartu: "Terima",
                  routing: "/terima_page",
                ),
                KirimTerimaRiwayat(
                  ikonkartu: Icons.wallet_outlined,
                  katakartu: "TopUp",
                  routing: "/isiSaldo_page",
                ),
                KirimTerimaRiwayat(
                  ikonkartu: Icons.add_box_outlined,
                  katakartu: "lainnya",
                  routing: "/lainnya_page",
                ),
              ],
            ),
            // berita pada home
            // bagian ini yang akan menjadi main menu pada home
            for (int i = 0; i < 5; i++) BeritaHome(beritaHomeData: BeritaHomeData(judulBerita: "judulberita ke-$i"))
            //   BeritaHome(
            //     judulBerita: "judul-berita ke-$i",
            //     kontenBerita:
            //         "konten-berita ke-$i yang mana akan melakukan $i ini adalah kata yang panjang yang akan saya gunakan untuk meunjukkan bug kata yang akan ditampilkan pada layar smartphone saya",
            //   ),
            // buat mainan baru lagi
          ],
        ),
      ),
    ));
  }
}

class BeritaHomeData {
  String judulBerita;
  String tanggalBerita;
  String kontenBerita;
  BeritaHomeData(
      {this.judulBerita = "judul berita", this.tanggalBerita = "tanggal berita", this.kontenBerita = "konten berita"});
}

// stateless widgets berita home untuk membuat kartu "berita home"
class BeritaHome extends StatelessWidget {
  final BeritaHomeData beritaHomeData;
  const BeritaHome({Key? key, required this.beritaHomeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BeritaDetailPage(
              beritaHomeData: beritaHomeData,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 125,
              height: 125,
              color: Colors.green[100],
              child: const Center(child: Text("gambar disini")),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                width: 100,
                height: 100,
                // color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      beritaHomeData.judulBerita.toTitleCase(),
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      beritaHomeData.kontenBerita.toCapitalized(),
                      style: Theme.of(context).textTheme.subtitle2,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
