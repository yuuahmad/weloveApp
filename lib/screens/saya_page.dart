import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welove/main.dart';

import '../services/auth_services.dart';

class SayaPage extends StatefulWidget {
  const SayaPage({Key? key}) : super(key: key);

  @override
  State<SayaPage> createState() => SayaPageState();
}

class SayaPageState extends State<SayaPage> {
  @override
  Widget build(BuildContext context) {
    Future<String?> userUid = context.read<AuthServices>().dapatkanUid();
    Future<String?> userEmail = context.read<AuthServices>().dapatkanEmail();
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
                        onTap: null,
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 212, 212, 212),
                                  borderRadius: BorderRadius.circular(100))),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          future: userEmail,
                          initialData: null,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Text(
                                "dummy",
                                style: Theme.of(context).textTheme.headline3,
                              );
                            } else {
                              return Text("Loading...", style: Theme.of(context).textTheme.headline3);
                            }
                          },
                        ),
                        Text(
                          "60 Wepoint",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        FutureBuilder(
                          future: userEmail,
                          initialData: null,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Text("Email: ${snapshot.data}", style: Theme.of(context).textTheme.headline6);
                            } else {
                              return Text("Loading...", style: Theme.of(context).textTheme.headline6);
                            }
                          },
                        ),
                        FutureBuilder(
                          future: userUid,
                          initialData: null,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Text(
                                "UID: ${snapshot.data}".replaceRange(25, null, "..."),
                                style: Theme.of(context).textTheme.headline6,
                              );
                            } else {
                              return Text("Loading...", style: Theme.of(context).textTheme.headline6);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // list berkelompok untuk pengaturan aplikasi
              // dimulai dari sini
              KelompokList(
                judulKelompokList: "pengaturan aplikasi",
                judulList: const ["pengaturan profil", "pengaturan keamanan", "akun terhubung"],
                routing: const ["/pengaturanProfil_page", "/pengaturanKeamanan_page", "/akunTerhubung_page"],
              ),

              KelompokList(
                judulKelompokList: "pengaturan umum",
                judulList: const ["pusat bantuan", "syarat dan ketentuan", "kebijakan privasi", "tentang aplikasi"],
                routing: const [
                  "/pusatBantuan_page",
                  "/syaratDanKetentuan_page",
                  "/kebijakanPrivasi_page",
                  "/tentangAplikasi_page"
                ],
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    context.read<AuthServices>().keluar();
                  },
                  child: TombolPenting(namaTombol: "keluar")),
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
  String judulKelompokList;
  // DaftarJudulKelompokList daftarJudulKelompokList;
  List<String> judulList;
  List<String> routing;

  KelompokList({Key? key, required this.judulKelompokList, required this.judulList, required this.routing})
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
