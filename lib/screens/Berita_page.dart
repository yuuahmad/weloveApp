import 'package:flutter/material.dart';
import 'package:welove/screens/homepage/home_page.dart';

class BeritaPage extends StatefulWidget {
  final BeritaHomeData beritaHomeData;
  BeritaPage({Key? key, required this.beritaHomeData}) : super(key: key);

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [Text(widget.beritaHomeData.judulBerita), Text(widget.beritaHomeData.kontenBerita)],
          ),
        ),
      ),
    );
  }
}
