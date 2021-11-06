import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_song/constants/color.dart';
import 'package:my_song/constants/text.dart';
import 'package:my_song/pages/arama_page.dart';
import 'package:my_song/pages/ayarlar_page.dart';
import 'package:my_song/pages/home_page.dart';
import 'package:my_song/pages/kitaplik_page.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class TaslakPage extends StatefulWidget {
  String uid;
  String email;
  String sifre;
  TaslakPage(
      {required this.uid, required this.email, required this.sifre, Key? key})
      : super(key: key);

  @override
  _TaslakPageState createState() => _TaslakPageState();
}

class _TaslakPageState extends State<TaslakPage> {
  int _seciliMenu = 0;

  @override
  void initState() {
    super.initState();
    String _veritabanindakiEmail;
    String _veritabanindakiSifre;
    _firebaseFirestore.collection('users').doc(widget.uid).get().then((value) {
      _veritabanindakiEmail = value.data()!['email'];
      _veritabanindakiSifre = value.data()!['sifre'];
      if (_veritabanindakiEmail != widget.email) {
        _veritabanindaEmailGuncelle(widget.email.toString());
      }
      if (_veritabanindakiSifre != widget.sifre) {
        _veritabanindaSifreGuncelle(widget.sifre.toString());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: _widgetGoster(_seciliMenu),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ConstantsColor.appColor2,
        selectedLabelStyle: ConstantsText.textStyle5,
        unselectedLabelStyle: ConstantsText.textStyle5,
        currentIndex: _seciliMenu,
        onTap: (index) {
          setState(() {
            _seciliMenu = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Anasayfa',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Arama',
            icon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Kitaplığın',
            icon: Icon(
              Icons.playlist_play,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Ayarlar',
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetGoster(int seciliMenu) {
    if (seciliMenu == 0) {
      return HomePage(
        uid: widget.uid,
      );
    } else if (seciliMenu == 1) {
      return AramaPage();
    } else if (seciliMenu == 2) {
      return KitaplikPage();
    } else {
      return AyarlarPage();
    }
  }

  Future<void> _veritabanindaEmailGuncelle(String _newEmail) async {
    try {
      _firebaseFirestore
          .collection('users')
          .doc(widget.uid.toString())
          .update({'email': _newEmail.toString()}).then(
              (value) => debugPrint('Veritabaninda ki email guncellendi!'));
    } catch (e) {
      debugPrint('Veritabani email guncelleme hatasi! ' + e.toString());
    }
  }

  Future<void> _veritabanindaSifreGuncelle(String _newSifre) async {
    try {
      _firebaseFirestore
          .collection('users')
          .doc(widget.uid.toString())
          .update({'sifre': _newSifre.toString()}).then(
              (value) => debugPrint('Veritabaninda ki sifre guncellendi!'));
    } catch (e) {
      debugPrint('Veritabani sifre guncelleme hatasi! ' + e.toString());
    }
  }
}
