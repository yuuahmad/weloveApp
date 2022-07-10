// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(scrollDirection: Axis.vertical, child: Text("berita_page")),
      ),
    );
  }
}
