import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'GirisSayfasi.dart';


class Kaydol extends StatefulWidget {
  @override
  _KaydolState createState() => _KaydolState();
}

class _KaydolState extends State<Kaydol> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _sifreController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _kayitOl() async {
    String email = _emailController.text;
    String sifre = _sifreController.text;

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: sifre);
      // İsteğe bağlı: Hesap oluşturulduktan sonra başka bir sayfaya yönlendirme
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AnaSayfa()));
    } catch (e) {
      print('Hata oluştu: $e');
      // Hata durumunda kullanıcıyı bilgilendirebilirsiniz.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hata"),
            content: Text("Hesap oluştururken bir hata oluştu. Lütfen bilgilerinizi kontrol edin."),
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
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-posta'),
            ),
            TextField(
              controller: _sifreController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Şifre'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _kayitOl,
              child: Text('Kayıt Ol'),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GirisSayfasi()),
                );
              },
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
