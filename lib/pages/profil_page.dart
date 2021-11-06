import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_dialog/custom_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_song/constants/color.dart';
import 'package:my_song/constants/text.dart';
import 'package:my_song/pages/giris_page.dart';
import 'package:image_picker/image_picker.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class ProfilPage extends StatefulWidget {
  String uid;
  ProfilPage({required this.uid, Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final _emailDegistirKey = GlobalKey<FormState>();
  final _sifreDegistirKey = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();
  int _uyelikSecimi = 0;
  String? _isim;
  String? _yeniEmail;
  String? _yeniSifre;
  String? _mevcutSifre;
  String? _mevcutEmail;
  String? _profilResmi = '';
  File? _secilenResim;
  String? _authEmail;
  String? _veritabaniSifre;

  @override
  void initState() {
    super.initState();
    _authEmail = _auth.currentUser!.email.toString();
    _firebaseFirestore.collection('users').doc(widget.uid).get().then((value) {
      setState(() {
        _veritabaniSifre = value.data()!['sifre'].toString();
        _isim = value.data()!['isim'].toString();
        _profilResmi = value.data()!['profilResmi'].toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        color: ConstantsColor.appColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    size: 40,
                    color: ConstantsColor.appColor2,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30,
              ),
              child: Center(
                child: _profilResmi == ''
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
                        backgroundImage: NetworkImage(_profilResmi.toString()),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: _isim == null
                    ? Text(
                        'Yükleniyor...',
                        style: ConstantsText.textStyle4,
                      )
                    : Text(
                        _isim.toString(),
                        style: ConstantsText.textStyle4,
                      ),
              ),
            ),
            Expanded(child: SingleChildScrollView(child: _secimDegistir())),
          ],
        ),
      ),
    );
  }

  Widget _secimDegistir() {
    if (_uyelikSecimi == 0) {
      //Ilk acilis sayfasi
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 48.0),
            child: Center(
              child: Text(
                'Üyelik İşlemleri',
                style: ConstantsText.textStyle6,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _uyelikSecimi = 1;
              });
            },
            child: Row(
              children: [
                Icon(
                  Icons.mail_outlined,
                  size: 28,
                  color: ConstantsColor.appColor2,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Email adresini değiştir",
                  style: ConstantsText.textStyle8,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _uyelikSecimi = 2;
              });
            },
            child: Row(
              children: [
                Icon(
                  Icons.vpn_key_outlined,
                  size: 28,
                  color: ConstantsColor.appColor2,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Şifreni değiştir",
                  style: ConstantsText.textStyle8,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => GirisPage()),
                  (route) => false);
            },
            child: Row(
              children: [
                Icon(
                  Icons.exit_to_app,
                  size: 28,
                  color: ConstantsColor.appColor2,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Çıkış yap",
                  style: ConstantsText.textStyle8,
                ),
              ],
            ),
          ),
        ],
      );
    } else if (_uyelikSecimi == 1) {
      //Email degistirme sayfasi
      return Center(
        child: Form(
          key: _emailDegistirKey,
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
                      _mevcutEmail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: ConstantsText.textStyle7,
                    cursorColor: ConstantsColor.appColor2,
                    decoration: InputDecoration(
                      labelText: 'Mevcut email adresi',
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
                      _yeniEmail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: ConstantsText.textStyle7,
                    cursorColor: ConstantsColor.appColor2,
                    decoration: InputDecoration(
                      labelText: 'Yeni email adresi',
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
                      _mevcutSifre = value;
                    },
                    obscureText: true,
                    style: ConstantsText.textStyle7,
                    cursorColor: ConstantsColor.appColor2,
                    decoration: InputDecoration(
                      labelText: 'Mevcut şifre',
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
                    if (_emailDegistirKey.currentState!.validate()) {
                      _emailDegistirKey.currentState!.save();
                      FocusScope.of(context).requestFocus(FocusNode());
                      _updateEmail(_mevcutEmail.toString(),
                          _yeniEmail.toString(), _mevcutSifre.toString());
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
                        'Email değiştir',
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
                      'Herşey doğru mu görünüyor?',
                      style: ConstantsText.subTitleTextStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _uyelikSecimi = 0;
                        });
                      },
                      child: Text(
                        'İptal et',
                        style: ConstantsText.textStyle7,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else if (_uyelikSecimi == 2) {
      //Sifre degistirme sayfasi
      return Center(
        child: Form(
          key: _sifreDegistirKey,
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
                      _mevcutEmail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: ConstantsText.textStyle7,
                    cursorColor: ConstantsColor.appColor2,
                    decoration: InputDecoration(
                      labelText: 'Mevcut email adresi',
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
                      _mevcutSifre = value;
                    },
                    obscureText: true,
                    style: ConstantsText.textStyle7,
                    cursorColor: ConstantsColor.appColor2,
                    decoration: InputDecoration(
                      labelText: 'Mevcut şifre',
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
                      _yeniSifre = value;
                    },
                    obscureText: true,
                    style: ConstantsText.textStyle7,
                    cursorColor: ConstantsColor.appColor2,
                    decoration: InputDecoration(
                      labelText: 'Yeni şifre',
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
                    if (_sifreDegistirKey.currentState!.validate()) {
                      _sifreDegistirKey.currentState!.save();
                      FocusScope.of(context).requestFocus(FocusNode());
                      _updatePassword(_mevcutEmail.toString(),
                          _mevcutSifre.toString(), _yeniSifre.toString());
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
                        'Şifre değiştir',
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
                      'Herşey doğru mu görünüyor?',
                      style: ConstantsText.subTitleTextStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _uyelikSecimi = 0;
                        });
                      },
                      child: Text(
                        'İptal et',
                        style: ConstantsText.textStyle7,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
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

  Future<void> _galeridenStorageye() async {
    XFile? resim = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _secilenResim = File(resim!.path);
    });
  }

  Future<void> _updateEmail(
      String _mevcutEmail, String _newEmail, String _mevcutSifre) async {
    try {
      if (_mevcutEmail == _authEmail && _mevcutSifre == _veritabaniSifre) {
        //Eger kullanici yakin zamanda oturum acmamis ise buraya dusecek ve email ve sifre bilgilerini kullanicidan almak gerekecektir.
        AuthCredential credential = EmailAuthProvider.credential(
            email: _mevcutEmail, password: _mevcutSifre);
        await _auth.currentUser!.reauthenticateWithCredential(credential);
        //Kullanicidan mail ve sifreleri tekrar aldiktan sonra guncelleme islemi yapiliyor.
        _auth.currentUser!.updateEmail(_newEmail).then((value) async {
          _veritabanindaEmailGuncelle(_newEmail);
          await _auth.currentUser!.sendEmailVerification();
          await _auth.signOut();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => GirisPage()),
              (route) => false);
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              content: Text(
                'Size email adresinizi onaylamanız için bir mail gönderdik.\nLütfen mail adresinizi onaylayınız.',
                style: ConstantsText.dialogSubtitleStyle,
                textAlign: TextAlign.center,
              ),
              title: Text(
                'Email güncelleme başarılı!',
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
          debugPrint(
              '(Ic try-catch) Email guncelleme islemi basarili bir sekilde gerceklestirilmistir!\nYeni email adresiniz: $_newEmail');
        });
      } else {
        debugPrint('Email sifre eslesmiyor!');
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            content: Text(
              'Lütfen girilen bilgileri kontrol edip tekrar deneyiniz.',
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
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          content: Text(
            'Lütfen girilen bilgileri kontrol edip tekrar deneyiniz.',
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
      debugPrint(
          'Email guncellenirken bir hata olustu:(Ic taraftaki try-catch) ' +
              e.toString());
    }
  }

  Future<void> _updatePassword(
      String _mevcutEmail, String _mevcutSifre, String _yeniSifre) async {
    try {
      if (_mevcutEmail == _authEmail && _mevcutSifre == _veritabaniSifre) {
        //Eger kullanici yakin zamanda oturum acmamis ise buraya dusecek ve emailve sifre bilgilerini kullanicidan almak gerekecektir.
        AuthCredential credential = EmailAuthProvider.credential(
            email: _mevcutEmail, password: _mevcutSifre);
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithCredential(credential);
        //Kullanicidan mail ve sifreleri tekrar aldiktan sonra guncelleme islemi yapiliyor.
        await _auth.currentUser!.updatePassword(_yeniSifre);
        _veritabanindaSifreGuncelle(_yeniSifre);
        await _auth.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => GirisPage()),
            (route) => false);
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            content: Text(
              'Şifre güncelleme işlemi başarılı bir şekilde gerçekleştirilmiştir.',
              style: ConstantsText.dialogSubtitleStyle,
              textAlign: TextAlign.center,
            ),
            title: Text(
              'Şifre güncelleme başarılı!',
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
        debugPrint(
            '(Ic try-catch) Sifreniz basarili bir sekilde guncellendi!\n Yeni sifreniz $_yeniSifre');
      } else {
        debugPrint('Email sifre eslesmiyor!');
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            content: Text(
              'Lütfen girilen bilgileri kontrol edip tekrar deneyiniz.',
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
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          content: Text(
            'Lütfen girilen bilgileri kontrol edip tekrar deneyiniz.',
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
      debugPrint(
          'Sifre guncellenirken bir hata olustu:(Ic taraftaki try-catch) ' +
              e.toString());
    }
  }
}
