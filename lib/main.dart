import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_expose_2k21/main_screen.dart';
import 'package:news_expose_2k21/functions.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Main(),
      )
  );
}

class Main extends StatefulWidget
{
  const Main({Key? key}) : super(key: key);
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main>
{
  @override
  Widget build(BuildContext context) => const AnnotatedRegion(
    value: SystemUiOverlayStyle(
      statusBarColor: colorChineseBlack,
      statusBarIconBrightness: Brightness.light,
    ),
    child: MainScreen(),
  );
}
