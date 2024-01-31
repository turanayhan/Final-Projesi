import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirebaseManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = Uuid();

  Future<void> notEkle(String baslik, String icerik) async {
    String belirliId = _uuid.v4();
    try {
      await _firestore.collection('notlar').doc(belirliId).set({
        'title': baslik,
        'content': icerik,
        'id' : belirliId,
        'olusturulmaTarihi': FieldValue.serverTimestamp(),
        'guncellemeTarihi': FieldValue.serverTimestamp(),
      });
      print('Not başarıyla eklendi.');
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  Future<void> notSil(String documentId) async {
    try {
      await _firestore.collection('notlar').doc(documentId).delete();
      print('Not başarıyla silindi.');
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  Future<void> notGuncelle(String documentId, String yeniBaslik, String yeniIcerik) async {
    try {
      await _firestore.collection('notlar').doc(documentId).update({
        'baslik': yeniBaslik,
        'icerik': yeniIcerik,
        'guncellemeTarihi': FieldValue.serverTimestamp(),
      });
      print('Not başarıyla güncellendi.');
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getNotlar() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('notlar').get();
      List<Map<String, dynamic>> notlar = [];

      querySnapshot.docs.forEach((doc) {
        notlar.add({
          'id': doc.id,
          'title': doc['title'],
          'content': doc['content'],
          'olusturulmaTarihi': doc['olusturulmaTarihi'],
          'guncellemeTarihi': doc['guncellemeTarihi'],
        });
      });

      return notlar;
    } catch (e) {
      print('Hata oluştu: $e');
      return [];
    }
  }
}