import 'package:flutter/material.dart';
import 'package:my_song/constants/color.dart';

class AyarlarPage extends StatefulWidget {
  const AyarlarPage({Key? key}) : super(key: key);

  @override
  _AyarlarPageState createState() => _AyarlarPageState();
}

class _AyarlarPageState extends State<AyarlarPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      color: ConstantsColor.appColor,
      child: SafeArea(
        child: Center(
          child: Text(
            'Ayarlar Page',
            style: TextStyle(fontSize: 42),
          ),
        ),
      ),
    );
  }
}
