// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:welove/main.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
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
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 200, 20, 10),
                      child: Text("siap menjadi penyelamat bumi?".toTitleCase(),
                          textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline1)),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                    child: Text(
                        "ini adalah halaman dan tahapan pertama dari proses menjadi penyelamat bumi. ikuti prosesnya sampai selesai untuk menjadi bagian dari penyelamat bumi sejati :)",
                        textAlign: TextAlign.center),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/scan_tempat');
                    },
                    child: TombolPenting(
                      namaTombol: "Siap",
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
