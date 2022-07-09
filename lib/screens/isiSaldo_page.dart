import 'package:flutter/material.dart';

class IsiSaldoPage extends StatefulWidget {
  const IsiSaldoPage({Key? key}) : super(key: key);

  @override
  State<IsiSaldoPage> createState() => IsiSaldoPageState();
}

class IsiSaldoPageState extends State<IsiSaldoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IsiSaldoPage"),
      ),
    );
  }
}
