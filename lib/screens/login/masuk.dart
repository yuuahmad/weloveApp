import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:welove/services/auth_services.dart';

class MasukPage extends StatefulWidget {
  const MasukPage({Key? key}) : super(key: key);

  @override
  State<MasukPage> createState() => _MasukPageState();
}

class _MasukPageState extends State<MasukPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("masuk app")),
        body: Column(
          children: [
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(labelText: "email"),
            ),
            TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(labelText: "password"),
            ),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<AuthServices>()
                      .masuk(email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());
                },
                child: Text("masuk"))
          ],
        ));
  }
}
