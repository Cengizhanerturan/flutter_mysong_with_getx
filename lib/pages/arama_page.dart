import 'package:flutter/material.dart';
import 'package:my_song/constants/color.dart';

class AramaPage extends StatefulWidget {
  const AramaPage({Key? key}) : super(key: key);

  @override
  _AramaPageState createState() => _AramaPageState();
}

class _AramaPageState extends State<AramaPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      color: ConstantsColor.appColor,
      child: SafeArea(
        child: Center(
          child: Text(
            'Arama Page',
            style: TextStyle(fontSize: 42),
          ),
        ),
      ),
    );
  }
}
