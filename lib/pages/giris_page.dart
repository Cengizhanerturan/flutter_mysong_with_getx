import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_song/constants/color.dart';
import 'package:my_song/constants/text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_song/pages/taslak_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class GirisPage extends StatefulWidget {
  const GirisPage({Key? key}) : super(key: key);

  @override
  _GirisPageState createState() => _GirisPageState();
}

class _GirisPageState extends State<GirisPage> {
  final _girisKey = GlobalKey<FormState>();
  final _kayitKey = GlobalKey<FormState>();
  final _sifreSifirlaKey = GlobalKey<FormState>();
  int _uyelikDurumu = 1;
  String? _isim;
  String? _kayitEmail;
  String? _kayitSifre;
  String? _girisEmail;
  String? _girisSifre;
  File? _secilenResim;
  String _downloadResim = '';
  ImagePicker imagePicker = ImagePicker();

  @override
  initState() {
    super.initState();
    if (_auth.currentUser != null) {
      _auth.signOut().then((value) => debugPrint('Oturum acikti! Kapatildi!'));
    }
    _auth.authStateChanges().listen((user) {
      setState(() {});
      if (user == null) {
        debugPrint('Kullanici oturumunu kapatti!');
      } else {
        debugPrint('Kullanici oturumunu acti!');
      }
    });

    // _turkcePopGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'turkce_pop',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint('Turkce pop getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _sonCikanlar().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'son_cikanlar',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint('Son cikanlar getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _turkceRapGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'turkce_rap',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint('Turkce rap getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _trapTurkGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'trap_turk',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint('Trap turk getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _akustikGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'akustik',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint('Akustik getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _rockTurkGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'turkce_rock',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint('Rock turk getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _arabeskGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'arabesk',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint('Arabesk getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _turkuGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'turku',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint('Turku getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _motiveKalGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'motive_kal',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint('Motive kal getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _onlarTurkceGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'turkce_onlar',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint('Onlar turkce getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _ikibinlerTurkceGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'turkce_ikibinler',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint(
    //         'Ikibinler turkce getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _seksenlerTurkceGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'turkce_seksenler',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint(
    //         'Seksenler turkce getirilirken hata olustu! ' + e.toString());
    //   }
    // });
    // _doksanlarTurkceGetir().then((value) {
    //   try {
    //     int listeUzunluk = value.tracks!.data!.length;
    //     for (int i = 0; i < listeUzunluk; i++) {
    //       _veritabaninaPlaylistEkle(
    //           'turkce_doksanlar',
    //           value.tracks!.data![i].artist!.id.toString(),
    //           value.tracks!.data![i].artist!.name.toString(),
    //           value.tracks!.data![i].artist!.tracklist.toString(),
    //           value.tracks!.data![i].id.toString(),
    //           value.tracks!.data![i].title.toString(),
    //           value.tracks!.data![i].duration.toString(),
    //           value.tracks!.data![i].preview.toString(),
    //           value.tracks!.data![i].album!.id.toString(),
    //           value.tracks!.data![i].album!.coverMedium.toString());
    //     }
    //   } catch (e) {
    //     debugPrint(
    //         'Doksanlar turkce getirilirken hata olustu! ' + e.toString());
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          final message = 'Çıkmak için tekrar basın.';
          Fluttertoast.showToast(
            msg: message,
          );
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          color: ConstantsColor.appColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Column(
                  children: [
                    Text(
                      ConstantsText.titleText,
                      style: ConstantsText.titleTextStyle,
                    ),
                    Text(
                      ConstantsText.subTitleText,
                      style: ConstantsText.subTitleTextStyle,
                    ),
                    _widgetDondur(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetDondur() {
    if (_uyelikDurumu == 0) {
      //Kayit Ekrani
      return Form(
        key: _kayitKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: _secilenResim == null
                  ? InkWell(
                      onTap: _galeridenStorageye,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: ConstantsColor.appColor3,
                        child: Center(
                          child: Icon(
                            Icons.photo_camera,
                            size: 40,
                            color: ConstantsColor.appColor,
                          ),
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(_secilenResim as File),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 1) {
                      return 'Lütfen isminizi giriniz.';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _isim = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: ConstantsText.textStyle7,
                  cursorColor: ConstantsColor.appColor2,
                  decoration: InputDecoration(
                    labelText: 'İsim',
                    labelStyle: ConstantsText.textStyle7,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: ConstantsColor.appColor2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  validator: (value) {
                    if (EmailValidator.validate(value!) == false) {
                      return 'Lütfen geçerli bir mail adresi giriniz.';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _kayitEmail = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: ConstantsText.textStyle7,
                  cursorColor: ConstantsColor.appColor2,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: ConstantsText.textStyle7,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: ConstantsColor.appColor2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Lütfen en az 6 karakterli bir şifre giriniz.';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _kayitSifre = value;
                  },
                  obscureText: true,
                  style: ConstantsText.textStyle7,
                  cursorColor: ConstantsColor.appColor2,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    labelStyle: ConstantsText.textStyle7,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: ConstantsColor.appColor2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: InkWell(
                onTap: () {
                  if (_kayitKey.currentState!.validate()) {
                    _kayitKey.currentState!.save();
                    FocusScope.of(context).requestFocus(FocusNode());
                    _emailSifreKullaniciOlustur(_kayitEmail.toString(),
                        _kayitSifre.toString(), _isim.toString());
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ConstantsColor.appColor2,
                  ),
                  child: Center(
                    child: Text(
                      'Kayıt Ol',
                      style: ConstantsText.textStyle2,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Text(
                    'Hesabınız var mı?',
                    style: ConstantsText.subTitleTextStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _uyelikDurumu = 1;
                      });
                    },
                    child: Text(
                      'Giriş yap',
                      style: ConstantsText.textStyle7,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (_uyelikDurumu == 1) {
      //Giris Ekrani
      return Form(
        key: _girisKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  validator: (value) {
                    if (EmailValidator.validate(value!) == false) {
                      return 'Lütfen geçerli bir mail adresi giriniz.';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _girisEmail = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: ConstantsText.textStyle7,
                  cursorColor: ConstantsColor.appColor2,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: ConstantsText.textStyle7,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: ConstantsColor.appColor2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Lütfen şifrenizi giriniz';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _girisSifre = value;
                  },
                  obscureText: true,
                  style: ConstantsText.textStyle7,
                  cursorColor: ConstantsColor.appColor2,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    labelStyle: ConstantsText.textStyle7,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: ConstantsColor.appColor2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: InkWell(
                onTap: () {
                  if (_girisKey.currentState!.validate()) {
                    _girisKey.currentState!.save();
                    FocusScope.of(context).requestFocus(FocusNode());
                    _emailSifreKullaniciGirisYap(
                        _girisEmail.toString(), _girisSifre.toString());
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ConstantsColor.appColor2,
                  ),
                  child: Center(
                    child: Text(
                      'Giriş yap',
                      style: ConstantsText.textStyle2,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Text(
                    'Hesabınız yok mu?',
                    style: ConstantsText.subTitleTextStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _uyelikDurumu = 0;
                      });
                    },
                    child: Text(
                      'Kayıt ol',
                      style: ConstantsText.textStyle7,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  'Şifrenizi mi unuttunuz?',
                  style: ConstantsText.subTitleTextStyle,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _uyelikDurumu = 2;
                    });
                  },
                  child: Text(
                    'Şifre sıfırla',
                    style: ConstantsText.textStyle7,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (_uyelikDurumu == 2) {
      //Sifre sifirlama Ekrani
      return Form(
        key: _sifreSifirlaKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  validator: (value) {
                    if (EmailValidator.validate(value!) == false) {
                      return 'Lütfen geçerli bir mail adresi giriniz.';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _girisEmail = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: ConstantsText.textStyle7,
                  cursorColor: ConstantsColor.appColor2,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: ConstantsText.textStyle7,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: ConstantsColor.appColor2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: InkWell(
                onTap: () {
                  if (_sifreSifirlaKey.currentState!.validate()) {
                    _sifreSifirlaKey.currentState!.save();
                    FocusScope.of(context).requestFocus(FocusNode());
                    _resetPassword(_girisEmail.toString());
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ConstantsColor.appColor2,
                  ),
                  child: Center(
                    child: Text(
                      'Şifre sıfırla',
                      style: ConstantsText.textStyle2,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Text(
                    'Hesabınız yok mu?',
                    style: ConstantsText.subTitleTextStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _uyelikDurumu = 0;
                      });
                    },
                    child: Text(
                      'Kayıt ol',
                      style: ConstantsText.textStyle7,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  'Şifreni hatırladın mı?',
                  style: ConstantsText.subTitleTextStyle,
                ),
                SizedBox(
                  height: 2,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _uyelikDurumu = 1;
                    });
                  },
                  child: Text(
                    'Giriş yap',
                    style: ConstantsText.textStyle7,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  void _emailSifreKullaniciOlustur(
      String _email, String _sifre, String _isim) async {
    try {
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _sifre);
      User? _yeniUser = _credential.user;
      await _yeniUser!.sendEmailVerification();
      if (_auth.currentUser != null) {
        _kayitKey.currentState!.reset();
        String _userID = _auth.currentUser!.uid.toString();
        try {
          if (_secilenResim != null) {
            var ref = firebase_storage.FirebaseStorage.instance
                .ref()
                .child('users')
                .child(_userID)
                .child('profilResmi');
            await ref.putFile(_secilenResim!);
            var url = await ref.getDownloadURL();
            setState(() {
              _downloadResim = url;
              _secilenResim = null;
            });
            debugPrint('Dowload url: ' + url.toString());
            //Burada ise kullanicinin yukledigi resimi veri tabanina kullanicinin kendi tablosuna kaydediyoruz
          }
        } on FirebaseException catch (e) {
          debugPrint('Firebase upload hatasi!' + e.toString());
        }
        _veritabaninaKullaniciEkle(
            _userID, _isim, _email, _sifre, _downloadResim);
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            content: Text(
              'Size email adresinizi onaylamanız için bir mail gönderdik.\nLütfen mail adresinizi onaylayınız.',
              style: ConstantsText.dialogSubtitleStyle,
              textAlign: TextAlign.center,
            ),
            title: Text(
              'Kayıt başarılı!',
              style: ConstantsText.dialogTitleStyle,
              textAlign: TextAlign.center,
            ),
            firstColor: Color(0xFF3CCF57),
            secondColor: Colors.white,
            headerIcon: Icon(
              Icons.check_circle_outline,
              size: 120.0,
              color: Colors.white,
            ),
          ),
        );
        await _auth.signOut();
      }
      debugPrint(_yeniUser.toString());
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          content: Text(
            'Bir hata oluştu...\nLütfen daha sonra tekrar deneyiniz.',
            style: ConstantsText.dialogSubtitleStyle,
            textAlign: TextAlign.center,
          ),
          title: Text(
            'Hata!',
            style: ConstantsText.dialogTitleStyle,
            textAlign: TextAlign.center,
          ),
          firstColor: ConstantsColor.errorColor,
          secondColor: Colors.white,
          headerIcon: Icon(
            Icons.error_outline_outlined,
            size: 120.0,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void _emailSifreKullaniciGirisYap(String _email, String _sifre) async {
    try {
      if (_auth.currentUser == null) {
        User? _oturumAcanUser = (await _auth.signInWithEmailAndPassword(
                email: _email, password: _sifre))
            .user;
        if (_oturumAcanUser!.emailVerified) {
          String _oturumAcanUserUID = _oturumAcanUser.uid.toString();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => TaslakPage(
                    uid: _oturumAcanUserUID, email: _email, sifre: _sifre),
              ),
              (route) => false);
        } else {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              content: Text(
                'Lütfen email adresinizi onaylayınız.',
                style: ConstantsText.dialogSubtitleStyle,
                textAlign: TextAlign.center,
              ),
              title: Text(
                'Onaysız hesap!',
                style: ConstantsText.dialogTitleStyle,
                textAlign: TextAlign.center,
              ),
              firstColor: ConstantsColor.errorColor,
              secondColor: Colors.white,
              headerIcon: Icon(
                Icons.error_outline_outlined,
                size: 120.0,
                color: Colors.white,
              ),
            ),
          );
          _auth.signOut();
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          content: Text(
            'Lütfen email adresinizi ve şifrenizi kontrol edip tekrar deneyiniz.',
            style: ConstantsText.dialogSubtitleStyle,
            textAlign: TextAlign.center,
          ),
          title: Text(
            'Geçersiz email-şifre kombinasyonu!',
            style: ConstantsText.dialogTitleStyle,
            textAlign: TextAlign.center,
          ),
          firstColor: ConstantsColor.errorColor,
          secondColor: Colors.white,
          headerIcon: Icon(
            Icons.error_outline_outlined,
            size: 120.0,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void _resetPassword(String _email) async {
    try {
      await _auth.sendPasswordResetEmail(email: _email);
      _sifreSifirlaKey.currentState!.reset();
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          content: Text(
            'Girmiş olduğunuz mail adresine şifre sıfırlama bağlantısı gönderilmiştir.',
            style: ConstantsText.dialogSubtitleStyle,
            textAlign: TextAlign.center,
          ),
          title: Text(
            'Şifre sıfırlama başarılı!',
            style: ConstantsText.dialogTitleStyle,
            textAlign: TextAlign.center,
          ),
          firstColor: Color(0xFF3CCF57),
          secondColor: Colors.white,
          headerIcon: Icon(
            Icons.check_circle_outline,
            size: 120.0,
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          content: Text(
            'Lütfen email adresinizi kontrol edip tekrar deneyiniz.',
            style: ConstantsText.dialogSubtitleStyle,
            textAlign: TextAlign.center,
          ),
          title: Text(
            'Geçersiz email adresi!',
            style: ConstantsText.dialogTitleStyle,
            textAlign: TextAlign.center,
          ),
          firstColor: ConstantsColor.errorColor,
          secondColor: Colors.white,
          headerIcon: Icon(
            Icons.error_outline_outlined,
            size: 120.0,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  Future<void> _galeridenStorageye() async {
    XFile? resim = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _secilenResim = File(resim!.path);
    });
  }

  Future<void> _veritabaninaKullaniciEkle(String _uid, String _isim,
      String _email, String _sifre, String _profilResmi) async {
    try {
      Map<String, dynamic> kullaniciEkle = Map();
      kullaniciEkle['uid'] = _uid;
      kullaniciEkle['isim'] = _isim;
      kullaniciEkle['email'] = _email;
      kullaniciEkle['sifre'] = _sifre;
      kullaniciEkle['profilResmi'] = _profilResmi;
      kullaniciEkle['kayitTarihi'] = FieldValue.serverTimestamp();
      _firebaseFirestore
          .collection('users')
          .doc(_uid)
          .set(
            kullaniciEkle,
            SetOptions(merge: true),
          )
          .then((value) {
        debugPrint('Kullanici veritabanina eklendi!');
      });
    } catch (e) {
      debugPrint('Veritabanina eklerken bir hata olustu! ' + e.toString());
    }
  }

  // Future<void> _veritabaninaPlaylistEkle(
  //     String _playlistIsim,
  //     String _artistID,
  //     String _artistName,
  //     String _artistTrackList,
  //     String _sarkiID,
  //     String _sarkiTitle,
  //     String _sarkiDuration,
  //     String _sarkiPreview,
  //     String _albumID,
  //     String _albumImage) async {
  //   try {
  //     Map<String, dynamic> playlistEkle = Map();
  //     playlistEkle['artistID'] = _artistID;
  //     playlistEkle['artistName'] = _artistName;
  //     playlistEkle['artistTrackList'] = _artistTrackList;
  //     playlistEkle['sarkiID'] = _sarkiID;
  //     playlistEkle['sarkiTitle'] = _sarkiTitle;
  //     playlistEkle['sarkiDuration'] = _sarkiDuration;
  //     playlistEkle['sarkiPreview'] = _sarkiPreview;
  //     playlistEkle['albumID'] = _albumID;
  //     playlistEkle['albumImage'] = _albumImage;

  //     _firebaseFirestore
  //         .collection('muzik')
  //         .doc('playlists')
  //         .collection(_playlistIsim.toString())
  //         .doc(_sarkiID.toString())
  //         .set(
  //           playlistEkle,
  //           SetOptions(merge: true),
  //         )
  //         .then((value) {
  //       debugPrint('${_playlistIsim} playlist veritabanina eklendi!');
  //     });
  //   } catch (e) {
  //     debugPrint(
  //         'Veritabanina playlist eklerken bir hata olustu! ' + e.toString());
  //   }
  // }

  // Future<TurkcePop> _turkcePopGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/6836336384?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return TurkcePop.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<SonCikanlar> _sonCikanlar() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/6305635104?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return SonCikanlar.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<TurkceRap> _turkceRapGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/6681799284?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return TurkceRap.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<TrapTurk> _trapTurkGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/7617463322?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return TrapTurk.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<AkustikTurk> _akustikGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/7658022062?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return AkustikTurk.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<TurkceRock> _rockTurkGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/6330235704?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return TurkceRock.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<Arabesk> _arabeskGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/1384038815?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return Arabesk.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<Turku> _turkuGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/872707323?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return Turku.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<MotiveKal> _motiveKalGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/6457319124?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return MotiveKal.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<OnlarTurkce> _onlarTurkceGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/7633541322?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return OnlarTurkce.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<IkibinlerTurkce> _ikibinlerTurkceGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/7626126022?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return IkibinlerTurkce.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<DoksanlarTurkce> _doksanlarTurkceGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/6423171724?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return DoksanlarTurkce.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }

  // Future<SeksenlerTurkce> _seksenlerTurkceGetir() async {
  //   var response = await http.get(Uri.parse(
  //       'https://deezerdevs-deezer.p.rapidapi.com/playlist/7606229862?rapidapi-key={api-key}'));
  //   if (response.statusCode == 200) {
  //     return SeksenlerTurkce.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('${response.statusCode.toString()}\nHata olustu!');
  //   }
  // }
}
