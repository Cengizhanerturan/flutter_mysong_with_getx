import 'package:flutter/material.dart';
import 'package:my_song/constants/color.dart';

class KitaplikPage extends StatefulWidget {
  const KitaplikPage({Key? key}) : super(key: key);

  @override
  _KitaplikPageState createState() => _KitaplikPageState();
}

class _KitaplikPageState extends State<KitaplikPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      color: ConstantsColor.appColor,
      child: SafeArea(
        child: Center(
          child: Text(
            'Kitaplik Page',
            style: TextStyle(fontSize: 42),
          ),
        ),
      ),
    );
  }
}
