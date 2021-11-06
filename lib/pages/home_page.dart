import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_song/constants/color.dart';
import 'package:my_song/constants/text.dart';
import 'package:my_song/controllers/muzik_controller.dart';
import 'package:my_song/pages/playlist_page.dart';
import 'package:my_song/pages/profil_page.dart';
import 'package:get/get.dart';

final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class HomePage extends StatefulWidget {
  String uid;
  HomePage({required this.uid, Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MuzikController muzikController = Get.put(MuzikController());

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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          color: ConstantsColor.appColor,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 0.0, top: 16.0),
                        child: Row(
                          children: [
                            Text(
                              'Son Çıkanlar',
                              style: ConstantsText.textStyle1,
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: ConstantsColor.textColor1,
                                  size: 28,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilPage(uid: widget.uid)));
                                  },
                                  icon: Icon(
                                    Icons.person,
                                    color: ConstantsColor.textColor1,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController.sonCikanlarListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlaylistPage(
                                                            playlistListe:
                                                                muzikController
                                                                    .sonCikanlarListe,
                                                            playlistTitle:
                                                                'Son Çıkanlar'),
                                                  ),
                                                );
                                              },
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .sonCikanlarListe[index]
                                                          ['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .sonCikanlarListe[
                                                      index]['artistName'],
                                                  muzikController
                                                          .sonCikanlarListe[
                                                      index]['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          'Türkçe Pop',
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController.turkcePopListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaylistPage(
                                                        playlistListe:
                                                            muzikController
                                                                .turkcePopListe,
                                                        playlistTitle:
                                                            'Türkçe Pop'),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .turkcePopListe[index]
                                                          ['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .turkcePopListe[index]
                                                      ['artistName'],
                                                  muzikController
                                                          .turkcePopListe[index]
                                                      ['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          'Türkçe Rap',
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController.turkceRapListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaylistPage(
                                                        playlistListe:
                                                            muzikController
                                                                .turkceRapListe,
                                                        playlistTitle:
                                                            'Türkçe Rap'),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .turkceRapListe[index]
                                                          ['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .turkceRapListe[index]
                                                      ['artistName'],
                                                  muzikController
                                                          .turkceRapListe[index]
                                                      ['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          'Türkçe Rock',
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController.turkceRockListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaylistPage(
                                                        playlistListe:
                                                            muzikController
                                                                .turkceRockListe,
                                                        playlistTitle:
                                                            'Türkçe Rock'),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .turkceRockListe[index]
                                                          ['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .turkceRockListe[
                                                      index]['artistName'],
                                                  muzikController
                                                          .turkceRockListe[
                                                      index]['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          'Arabesk',
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController.arabeskListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaylistPage(
                                                        playlistListe:
                                                            muzikController
                                                                .arabeskListe,
                                                        playlistTitle:
                                                            'Arabesk'),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .arabeskListe[index]
                                                          ['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .arabeskListe[index]
                                                      ['artistName'],
                                                  muzikController
                                                          .arabeskListe[index]
                                                      ['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          'Türkü',
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController.turkuListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaylistPage(
                                                        playlistListe:
                                                            muzikController
                                                                .turkuListe,
                                                        playlistTitle: 'Türkü'),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .turkuListe[index]
                                                          ['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .turkuListe[index]
                                                      ['artistName'],
                                                  muzikController
                                                          .turkuListe[index]
                                                      ['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          'Trap Türk',
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController.trapTurkListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaylistPage(
                                                        playlistListe:
                                                            muzikController
                                                                .trapTurkListe,
                                                        playlistTitle:
                                                            'Trap Türk'),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .trapTurkListe[index]
                                                          ['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .trapTurkListe[index]
                                                      ['artistName'],
                                                  muzikController
                                                          .trapTurkListe[index]
                                                      ['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          'Akustik',
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController.akustikListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaylistPage(
                                                        playlistListe:
                                                            muzikController
                                                                .akustikListe,
                                                        playlistTitle:
                                                            'Akustik'),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .akustikListe[index]
                                                          ['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .akustikListe[index]
                                                      ['artistName'],
                                                  muzikController
                                                          .akustikListe[index]
                                                      ['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          'Motive Kal',
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController.motivekalListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaylistPage(
                                                        playlistListe:
                                                            muzikController
                                                                .motivekalListe,
                                                        playlistTitle:
                                                            'Motive Kal'),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .motivekalListe[index]
                                                          ['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .motivekalListe[index]
                                                      ['artistName'],
                                                  muzikController
                                                          .motivekalListe[index]
                                                      ['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          "10'lar Türkçe",
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController.turkceOnlarListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaylistPage(
                                                        playlistListe:
                                                            muzikController
                                                                .turkceOnlarListe,
                                                        playlistTitle:
                                                            "10'lar Türkçe"),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .turkceOnlarListe[index]
                                                          ['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .turkceOnlarListe[
                                                      index]['artistName'],
                                                  muzikController
                                                          .turkceOnlarListe[
                                                      index]['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          "00'lar Türkçe",
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController
                                .turkceIkibinlerListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => PlaylistPage(
                                                    playlistListe: muzikController
                                                        .turkceIkibinlerListe,
                                                    playlistTitle:
                                                        "00'lar Türkçe"),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .turkceIkibinlerListe[
                                                          index]['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .turkceIkibinlerListe[
                                                      index]['artistName'],
                                                  muzikController
                                                          .turkceIkibinlerListe[
                                                      index]['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          "90'lar Türkçe",
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController
                                .turkceDoksanlarListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => PlaylistPage(
                                                    playlistListe: muzikController
                                                        .turkceDoksanlarListe,
                                                    playlistTitle:
                                                        "90'lar Türkçe"),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .turkceDoksanlarListe[
                                                          index]['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .turkceDoksanlarListe[
                                                      index]['artistName'],
                                                  muzikController
                                                          .turkceDoksanlarListe[
                                                      index]['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          "80'ler Türkçe",
                          style: ConstantsText.textStyle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Container(
                          height: 250,
                          child: Obx(() {
                            if (muzikController
                                .turkceSeksenlerListeLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return index == 9
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => PlaylistPage(
                                                    playlistListe: muzikController
                                                        .turkceSeksenlerListe,
                                                    playlistTitle:
                                                        "80'ler Türkçe"),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.chevron_right_sharp,
                                                  size: 36,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 180,
                                                child: Image.network(
                                                  muzikController
                                                      .turkceSeksenlerListe[
                                                          index]['albumImage']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              _isimDuzenle(
                                                  muzikController
                                                          .turkceSeksenlerListe[
                                                      index]['artistName'],
                                                  muzikController
                                                          .turkceSeksenlerListe[
                                                      index]['sarkiTitle']),
                                            ],
                                          ),
                                        );
                                },
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _isimDuzenle(String sanatciIsmi, String sarkiIsmi) {
    if (sanatciIsmi.length > 9 && sarkiIsmi.length > 9) {
      return Text(
        sanatciIsmi.substring(0, 10).toString() +
            '\n' +
            sarkiIsmi.substring(0, 10).toString(),
        style: ConstantsText.textStyle2,
      );
    } else if (sanatciIsmi.length > 9 && sarkiIsmi.length <= 9) {
      return Text(
        sanatciIsmi.substring(0, 10).toString() + '\n' + sarkiIsmi.toString(),
        style: ConstantsText.textStyle2,
      );
    } else if (sanatciIsmi.length <= 9 && sarkiIsmi.length > 9) {
      return Text(
        sanatciIsmi.toString() + '\n' + sarkiIsmi.substring(0, 10).toString(),
        style: ConstantsText.textStyle2,
      );
    } else {
      return Text(
        sanatciIsmi.toString() + '\n' + sarkiIsmi.toString(),
        style: ConstantsText.textStyle2,
      );
    }
  }

  // Future<void> _sonCikanlarGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('son_cikanlar')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (sonCikanlarListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         sonCikanlarListe.add(value.docs[i].data());
  //       }
  //       debugPrint('Son cikanlar getirildi!');
  //     } else {
  //       debugPrint('Son cikanlar liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _akustikGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('akustik')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (akustikListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         akustikListe.add(value.docs[i].data());
  //       }
  //       debugPrint('Akustik getirildi!');
  //     } else {
  //       debugPrint('Akustik liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _arabeskGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('arabesk')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (arabeskListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         arabeskListe.add(value.docs[i].data());
  //       }
  //       debugPrint('Akustik getirildi!');
  //     } else {
  //       debugPrint('Akustik liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _motiveKalGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('motive_kal')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (motivekalListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         motivekalListe.add(value.docs[i].data());
  //       }
  //       debugPrint('Motive kal getirildi!');
  //     } else {
  //       debugPrint('Motive kal liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _trapTurkGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('trap_turk')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (trapTurkListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         trapTurkListe.add(value.docs[i].data());
  //       }
  //       debugPrint('Trap turk getirildi!');
  //     } else {
  //       debugPrint('Trap turk liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _turkceDoksanlarGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('turkce_doksanlar')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (turkceDoksanlarListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         turkceDoksanlarListe.add(value.docs[i].data());
  //       }
  //       debugPrint("Turkce 90'lar getirildi!");
  //     } else {
  //       debugPrint('Turkce 90 lar liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _turkceIkibinlerGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('turkce_ikibinler')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (turkceIkibinlerListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         turkceIkibinlerListe.add(value.docs[i].data());
  //       }
  //       debugPrint("Turkce 2000'ler getirildi!");
  //     } else {
  //       debugPrint('Turkce 2000 ler liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _turkceOnlarGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('turkce_onlar')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (turkceOnlarListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         turkceOnlarListe.add(value.docs[i].data());
  //       }
  //       debugPrint("Turkce 2010'lar getirildi!");
  //     } else {
  //       debugPrint('Turkce 2010 lar liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _turkcePopGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('turkce_pop')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (turkcePopListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         turkcePopListe.add(value.docs[i].data());
  //       }
  //       debugPrint("Turkce pop getirildi!");
  //     } else {
  //       debugPrint('Turkce pop liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _turkceRapGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('turkce_rap')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (turkceRapListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         turkceRapListe.add(value.docs[i].data());
  //       }
  //       debugPrint("Turkce rap getirildi!");
  //     } else {
  //       debugPrint('Turkce rap liste oldugu ici getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _turkceRockGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('turkce_rock')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (turkceRockListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         turkceRockListe.add(value.docs[i].data());
  //       }
  //       debugPrint("Turkce rock getirildi!");
  //     } else {
  //       debugPrint('Turkce rock liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _turkceSeksenlerGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('turkce_seksenler')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (turkceSeksenlerListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         turkceSeksenlerListe.add(value.docs[i].data());
  //       }
  //       debugPrint("Turkce seksenler getirildi!");
  //     } else {
  //       debugPrint('Turkce seksenler liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _turkuGetir() async {
  //   _firebaseFirestore
  //       .collection('muzik')
  //       .doc('playlists')
  //       .collection('turku')
  //       .get()
  //       .then((value) {
  //     int listeUzunlik = value.size;
  //     if (turkuListe.length == 0) {
  //       for (int i = 0; i < listeUzunlik; i++) {
  //         turkuListe.add(value.docs[i].data());
  //       }
  //       debugPrint("Turku getirildi!");
  //     } else {
  //       debugPrint('Turku liste oldugu icin getirilmedi!');
  //     }
  //   });
  // }

  // Future<void> _refresh() async {
  //   await _sonCikanlarGetir();
  //   await _akustikGetir();
  //   await _arabeskGetir();
  //   await _motiveKalGetir();
  //   await _trapTurkGetir();
  //   await _turkceDoksanlarGetir();
  //   await _turkceIkibinlerGetir();
  //   await _turkceOnlarGetir();
  //   await _turkcePopGetir();
  //   await _turkceRapGetir();
  //   await _turkceRockGetir();
  //   await _turkceSeksenlerGetir();
  //   await _turkuGetir();
  //   setState(() {});
  // }
}
