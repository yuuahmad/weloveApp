// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:welove/main.dart';
import 'package:welove/screens/mainMenu/berita/berita_page.dart';
import 'package:welove/screens/mainMenu/home_page.dart';
import 'package:welove/screens/mainMenu/saya_page.dart';
import 'package:welove/screens/scan/scan_page.dart';
import 'package:welove/screens/mainMenu/store_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  // ignore: unused_field
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List layarDariBottomNavbar = [HomePage(), StorePage(), ScanPage(), BeritaPage(), SayaPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layarDariBottomNavbar[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green[600],
        selectedIconTheme: IconThemeData(size: 30),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop_outlined),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_outlined),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_outlined),
            label: 'Berita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: 'Saya',
          ),
        ],
      ),
    );
  }
}

class KirimTerimaRiwayat extends StatelessWidget {
  IconData ikonkartu;
  String katakartu;
  String routing;
  KirimTerimaRiwayat({Key? key, required this.ikonkartu, required this.katakartu, required this.routing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      // color: Colors.green[50],
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routing);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(children: [
            Icon(
              ikonkartu,
              size: 40,
              color: Colors.green[500],
            ),
            SizedBox(
              height: 5,
            ),
            Center(child: Text(katakartu.toTitleCase(), style: Theme.of(context).textTheme.subtitle2))
          ]),
        ),
      ),
    );
  }
}

class ListLainLain extends StatelessWidget {
  IconData ikonLainLain;
  String teksLainLain;
  ListLainLain({Key? key, required this.ikonLainLain, required this.teksLainLain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Card(
        color: Colors.green[50],
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(children: [
            Icon(
              ikonLainLain,
              size: 35,
              color: Colors.blue[300],
            ),
            SizedBox(
              width: 15,
            ),
            Text(teksLainLain.toTitleCase(), style: Theme.of(context).textTheme.headline1),
          ]),
        ),
      ),
    );
  }
}

// buat tipe data berita home data untuk melakukan dynamic routing
