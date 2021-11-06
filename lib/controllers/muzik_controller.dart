import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class MuzikController extends GetxController {
  var sonCikanlarListe = [].obs;
  var akustikListe = [].obs;
  var arabeskListe = [].obs;
  var motivekalListe = [].obs;
  var trapTurkListe = [].obs;
  var turkceDoksanlarListe = [].obs;
  var turkceIkibinlerListe = [].obs;
  var turkceOnlarListe = [].obs;
  var turkceSeksenlerListe = [].obs;
  var turkcePopListe = [].obs;
  var turkceRapListe = [].obs;
  var turkceRockListe = [].obs;
  var turkuListe = [].obs;

  var sonCikanlarListeLoading = true.obs;
  var akustikListeLoading = true.obs;
  var arabeskListeLoading = true.obs;
  var motivekalListeLoading = true.obs;
  var trapTurkListeLoading = true.obs;
  var turkceDoksanlarListeLoading = true.obs;
  var turkceIkibinlerListeLoading = true.obs;
  var turkceOnlarListeLoading = true.obs;
  var turkceSeksenlerListeLoading = true.obs;
  var turkcePopListeLoading = true.obs;
  var turkceRapListeLoading = true.obs;
  var turkceRockListeLoading = true.obs;
  var turkuListeLoading = true.obs;

  @override
  void onInit() {
    //GetX de onInit metodu widgeta bellek ayrildiktan sonra cagirilir.
    super.onInit();
    _veritabanindanMuzikGetir(
            sonCikanlarListe, 'son_cikanlar', sonCikanlarListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(akustikListe, 'akustik', akustikListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(arabeskListe, 'arabesk', arabeskListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(
            motivekalListe, 'motive_kal', motivekalListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(trapTurkListe, 'trap_turk', trapTurkListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(turkceDoksanlarListe, 'turkce_doksanlar',
            turkceDoksanlarListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(turkceIkibinlerListe, 'turkce_ikibinler',
            turkceIkibinlerListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(
            turkceOnlarListe, 'turkce_onlar', turkceOnlarListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(turkceSeksenlerListe, 'turkce_seksenler',
            turkceSeksenlerListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(
            turkcePopListe, 'turkce_pop', turkcePopListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(
            turkceRapListe, 'turkce_rap', turkceRapListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(
            turkceRockListe, 'turkce_rock', turkceRockListeLoading)
        .then((value) {});
    _veritabanindanMuzikGetir(turkuListe, 'turku', turkuListeLoading)
        .then((value) {});
  }

  Future<void> _veritabanindanMuzikGetir(
      List listeAdi, String collectionAdi, var listeLoading) async {
    try {
      listeLoading(true);
      _firebaseFirestore
          .collection('muzik')
          .doc('playlists')
          .collection('$collectionAdi')
          .get()
          .then((value) {
        int listeUzunluk = value.size;
        if (listeAdi.length == 0) {
          for (int i = 0; i < listeUzunluk; i++) {
            listeAdi.add(value.docs[i].data());
          }
          listeLoading(false);
        } else {
          print('$collectionAdi liste oldugu icin getirilmedi!');
        }
      });
    } catch (e) {
      print('Veri tabanindan $collectionAdi getirilirken bir hata olustu! ' +
          e.toString());
    }
  }
}
