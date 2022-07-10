import 'package:flutter/material.dart';

class TerimaPage extends StatefulWidget {
  const TerimaPage({Key? key}) : super(key: key);

  @override
  State<TerimaPage> createState() => _TerimaPageState();
}

class _TerimaPageState extends State<TerimaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TerimaPage"),
      ),
    );
  }
}
