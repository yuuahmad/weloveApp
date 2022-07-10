// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
        child: SingleChildScrollView(scrollDirection: Axis.vertical, child: Text("scanPage")),
      ),
    );
  }
}
