import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:welove/firebase_options.dart';
import 'package:welove/screens/login/daftar.dart';
import 'package:welove/screens/login/masuk.dart';
import 'package:welove/screens/lokasi_page.dart';
import 'package:welove/screens/mainMenu/main_page.dart';
import 'package:welove/screens/mainMenu/saya_page.dart';
import 'package:welove/screens/saya/pengaturan_profil_page.dart';
import 'package:welove/screens/scan/masukkan_sampah_page.dart';
import 'package:welove/screens/scan/scan_sampah.dart';
import 'package:welove/screens/scan/scan_tempat.dart';
import 'package:welove/screens/wepay/isi_saldo_page.dart';
import 'package:welove/screens/wepay/kirim_page.dart';
import 'package:welove/screens/wepay/lainnya_page.dart';
import 'package:welove/screens/wepay/terima_page.dart';
import 'package:welove/services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ignore: prefer_const_constructors
        ChangeNotifierProvider<SimpanDataTempat>(create: (_) => SimpanDataTempat()),
        Provider<AuthServices>(create: (_) => AuthServices(FirebaseAuth.instance)),
        StreamProvider(create: ((context) => context.read<AuthServices>().keadaanAuthberubah), initialData: null)
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Welove',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            // '/': (context) => const AuthWraper(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/kirim_page': (context) => const KirimPage(),
            '/terima_page': (context) => const TerimaPage(),
            '/lokasi_page': (context) => const LokasiPage(),
            '/lainnya_page': (context) => const LainnyaPage(),
            '/isiSaldo_page': (context) => const IsiSaldoPage(),
            '/saya_page': (context) => const SayaPage(),
            '/pengaturanProfil_page': (context) => const PengaturanProfilPage(),
            '/daftar_page': (context) => const DaftarPage(),
            // untuk scan sampah,dan scan tempat untuk hasilnya, sudah diinclude kedalam
            // kedua page diatas :)
            '/scan_tempat': (context) => const ScanTempat(),
            '/scan_sampah': (context) => const ScanSampah(),
            '/masukkan_sampah_page': (context) => const MasukkanSampahPage(),
          },
          home: const AuthWraper(),
          theme: ThemeData(
              colorScheme: const ColorScheme.light().copyWith(primary: Colors.green[600]),
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline1: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w400, fontSize: 25),
                    headline2: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 23),
                    headline3: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                    headline4: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                    headline5: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12),
                    headline6: const TextStyle(
                        color: Color.fromARGB(255, 190, 255, 193), fontWeight: FontWeight.w400, fontSize: 14),
                    subtitle1: const TextStyle(color: Colors.black, fontSize: 18),
                    subtitle2: const TextStyle(
                      color: Colors.black,
                    ),
                  ))),
    );
  }
}

class AuthWraper extends StatelessWidget {
  const AuthWraper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apakahAdaUser = context.watch<User?>();
    if (apakahAdaUser != null) {
      return const MainPage();
    } else {
      return const MasukPage();
    }
  }
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class TombolPenting extends StatelessWidget {
  final String namaTombol;
  final Color? warnaTombol;
  const TombolPenting({Key? key, this.namaTombol = "tombol", this.warnaTombol = const Color.fromARGB(255, 67, 160, 71)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 140, vertical: 3),
        decoration: BoxDecoration(
          color: warnaTombol,
          borderRadius: BorderRadius.circular(55),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            namaTombol.toTitleCase(),
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
    );
  }
}
