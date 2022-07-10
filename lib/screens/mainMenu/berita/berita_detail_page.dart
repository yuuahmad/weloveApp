import 'package:flutter/material.dart';
import 'package:welove/screens/mainMenu/home_page.dart';

class BeritaDetailPage extends StatefulWidget {
  final BeritaHomeData beritaHomeData;
  const BeritaDetailPage({Key? key, required this.beritaHomeData}) : super(key: key);

  @override
  State<BeritaDetailPage> createState() => _BeritaDetailPageState();
}

class _BeritaDetailPageState extends State<BeritaDetailPage> {
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
