import 'package:flutter/material.dart';
import 'package:welove/main.dart';

class SayaPage extends StatefulWidget {
  const SayaPage({Key? key}) : super(key: key);

  @override
  State<SayaPage> createState() => SayaPageState();
}

class SayaPageState extends State<SayaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                // color: Colors.green[600],
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      )
                    ],
                    color: Colors.green[500],
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/saya_page");
                        },
                        child: SizedBox(
                          height: 55,
                          width: 55,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 212, 212, 212), borderRadius: BorderRadius.circular(55))),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ahmad yusuf maulana".toTitleCase(), style: Theme.of(context).textTheme.headline3),
                        Text(
                          "60" + " Wepoint",
                          style: Theme.of(context).textTheme.headline4,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
