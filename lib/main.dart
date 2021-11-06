import 'package:flutter/material.dart';
import 'package:my_song/constants/text.dart';
import 'package:my_song/pages/giris_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          textTheme: TextTheme(
            //Formlardaki hata mesajlari icin
            caption: ConstantsText.hataTextStyle,
          )),
      title: 'Mysong',
      home: GirisPage(),
    );
  }
}
