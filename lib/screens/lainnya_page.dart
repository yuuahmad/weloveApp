import 'package:flutter/material.dart';

class LainnyaPage extends StatefulWidget {
  const LainnyaPage({Key? key}) : super(key: key);

  @override
  State<LainnyaPage> createState() => _LainnyaPageState();
}

class _LainnyaPageState extends State<LainnyaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LainnyaPage"),
      ),
    );
  }
}
