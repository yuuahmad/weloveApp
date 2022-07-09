import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welove/firebase_options.dart';
import 'package:welove/screens/homepage/home_page.dart';
import 'package:welove/screens/login/masuk.dart';
import 'package:welove/screens/lokasi_page.dart';
import 'package:welove/services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        Provider<AuthServices>(create: (_) => AuthServices(FirebaseAuth.instance)),
        StreamProvider(create: ((context) => context.read<AuthServices>().keadaanAuthberubah), initialData: null)
      ],
      child: MaterialApp(
          title: 'Welove',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            // '/': (context) => const AuthWraper(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/second': (context) => const LokasiPage(),
          },
          home: const AuthWraper(),
          theme: ThemeData(
              colorScheme: const ColorScheme.light().copyWith(primary: Colors.green[600]),
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline1: TextStyle(color: Colors.green[400], fontWeight: FontWeight.w500, fontSize: 25),
                    headline2: TextStyle(color: Colors.green[400], fontWeight: FontWeight.w500, fontSize: 23),
                    headline3: TextStyle(color: Colors.green[400], fontWeight: FontWeight.w500, fontSize: 18),
                    headline4: TextStyle(color: Colors.green[400], fontWeight: FontWeight.w500, fontSize: 16),
                    headline5: TextStyle(color: Colors.green[400], fontWeight: FontWeight.w500, fontSize: 12),
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
      return const HomePage();
    } else {
      return const MasukPage();
    }
  }
}
