import 'package:flutter/material.dart';

import 'FirebaseManager.dart';


class KayitSayfasi extends StatefulWidget {
  @override
  _KayitSayfasiState createState() => _KayitSayfasiState();
}

class _KayitSayfasiState extends State<KayitSayfasi> {
  final TextEditingController _notbasligi = TextEditingController();
  final TextEditingController _noticerigi = TextEditingController();


  FirebaseManager _firebaseManager = FirebaseManager();

  void _kayitEkle() {
    String notbasligi = _notbasligi.text;
    String noticerigi = _noticerigi.text;


    if (notbasligi.isNotEmpty && noticerigi.isNotEmpty) {
      _firebaseManager.notEkle(notbasligi,noticerigi);
      // İsteğe bağlı: Kayıt eklendikten sonra başka bir sayfaya yönlendirme
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DigerSayfa()));
    } else {
      // Kullanıcıdan gerekli bilgileri doldurmasını isteyebilirsiniz.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Uyarı"),
            content: Text("Lütfen tüm alanları doldurun."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Tamam"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Sayfası'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _notbasligi,
              decoration: InputDecoration(labelText: 'Not Baslıgı'),
            ),
            TextField(
              controller: _noticerigi,
              decoration: InputDecoration(labelText: 'İçerik'),
            ),

            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _kayitEkle,
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}