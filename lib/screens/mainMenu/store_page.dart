// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(scrollDirection: Axis.vertical, child: Text("store page")),
      ),
    );
  }
}
