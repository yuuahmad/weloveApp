// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // kartu tanda pengenal dan ucapan hai
            Card(
              margin: const EdgeInsets.all(10),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text("ini gambar"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "ahmad yusuf maulana",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text("We point: 123"),
                        ElevatedButton(onPressed: null, child: Text("edit profil"))
                      ],
                    )
                  ],
                ),
              ),
            ),
            // tombol kirim sampah dan pembelian produk
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                ElevatedButton(onPressed: null, child: Text("Kirim Sampah")),
                SizedBox(
                  width: 25,
                ),
                ElevatedButton(onPressed: null, child: Text("Pembelian produk")),
              ],
            ),
            // tombol bayar kirim terima, dan riwayat
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KirimTerimaRiwayat(
                  ikonkartu: Icons.payment_outlined,
                  katakartu: "bayar",
                ),
                KirimTerimaRiwayat(ikonkartu: Icons.send_outlined, katakartu: "kirim"),
                KirimTerimaRiwayat(ikonkartu: Icons.call_received_outlined, katakartu: "terima"),
                KirimTerimaRiwayat(ikonkartu: Icons.history_outlined, katakartu: "riwayat"),
              ],
            ),
            // tombol list lain lain
            // dan ini adalah list yang mengakhiri home view
            ListLainLain(ikonLainLain: Icons.shopping_bag_outlined, teksLainLain: "keranjang saya"),
            ListLainLain(ikonLainLain: Icons.layers_outlined, teksLainLain: "terakhir dilihat"),
            ListLainLain(ikonLainLain: Icons.settings_outlined, teksLainLain: "pengaturan akun"),
            ListLainLain(ikonLainLain: Icons.help_outline, teksLainLain: "pusat bantuan"),
          ],
        ),
      )),
    );
  }
}

class KirimTerimaRiwayat extends StatelessWidget {
  IconData ikonkartu;
  String katakartu;
  KirimTerimaRiwayat({Key? key, required this.ikonkartu, required this.katakartu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.green[50],
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/second");
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(children: [
            Icon(
              ikonkartu,
              size: 45,
              color: Colors.blue[300],
            ),
            Center(
                child: Text(
              katakartu.toTitleCase(),
              style: TextStyle(fontSize: 16),
            ))
          ]),
        ),
      ),
    );
  }
}

class ListLainLain extends StatelessWidget {
  IconData ikonLainLain;
  String teksLainLain;
  ListLainLain({Key? key, required this.ikonLainLain, required this.teksLainLain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Card(
        color: Colors.green[50],
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(children: [
            Icon(
              ikonLainLain,
              size: 35,
              color: Colors.blue[300],
            ),
            SizedBox(
              width: 15,
            ),
            Text(teksLainLain.toTitleCase(), style: Theme.of(context).textTheme.headline1),
          ]),
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
