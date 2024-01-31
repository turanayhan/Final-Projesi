import 'package:finalprojesi/Note.dart';
import 'package:flutter/material.dart';

import 'FirebaseManager.dart';


class Home extends StatefulWidget {
  late final Note model;


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController kitapAdiController = TextEditingController();
  final TextEditingController yazarController = TextEditingController();
  final TextEditingController sayfaSayisiController = TextEditingController();
  final TextEditingController yayineviController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController basimYiliController = TextEditingController();
  bool yayinlandi = false;
  String selectedKategori = '';

  @override
  void initState() {
    super.initState();
    FirebaseManager firebaseManager = FirebaseManager();


    //firebaseManager.kayitEkle('John Doe', '12345678901', '12345');


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitap Ekle'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: kitapAdiController,
              decoration: InputDecoration(labelText: 'Kitap Adı'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: yazarController,
              decoration: InputDecoration(labelText: 'Yazar'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: sayfaSayisiController,
              decoration: InputDecoration(labelText: 'Sayfa Sayısı'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: yayineviController,
              decoration: InputDecoration(labelText: 'Yayınevi'),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [

                Expanded(
                  child: TextField(
                    controller: kategoriController,
                    decoration: InputDecoration(labelText: 'Kategori'),
                    enabled: false,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: selectedKategori.isNotEmpty ? Colors.black : Colors.grey, // Soluk renk
                    ),

                  ),
                ),
                SizedBox(width: 16.0),
                DropdownButton<String>(

                  items: <String>['Roman', 'Edebiyat', 'Şiir', 'Tarih','Ansiklopedi'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedKategori = value!;
                      kategoriController.text = selectedKategori;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: basimYiliController,
              decoration: InputDecoration(labelText: 'Basım Yılı'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text('Listede Yayınlanacak mı?'),
              value: yayinlandi,
              onChanged: (value) {
                setState(() {
                  yayinlandi = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {






              },
              child: Text('Kaydet'),
            ),

          ],
        ),
      ),
    );
  }
}