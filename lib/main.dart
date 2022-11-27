import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_expose_2k21/functions.dart';
import 'package:news_expose_2k21/home_screen.dart';
import 'package:news_expose_2k21/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Main(),
  ));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  initMain() => StreamBuilder<User?>(
        stream: firebaseAuth.authStateChanges(),
        builder: (BuildContext context, snapshot) =>
            snapshot.hasData ? const HomeScreen() : const MainScreen(),
      );

  @override
  Widget build(BuildContext context) => AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: colorChineseBlack,
          statusBarIconBrightness: Brightness.light,
        ),
        child: initMain(),
      );
}
