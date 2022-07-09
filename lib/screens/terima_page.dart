import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

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
        title: Text("TerimaPage"),
      ),
    );
  }
}
