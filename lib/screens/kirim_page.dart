import 'package:flutter/material.dart';

class KirimPage extends StatefulWidget {
  const KirimPage({Key? key}) : super(key: key);

  @override
  State<KirimPage> createState() => _KirimPageState();
}

class _KirimPageState extends State<KirimPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KirimPage"),
      ),
    );
  }
}
