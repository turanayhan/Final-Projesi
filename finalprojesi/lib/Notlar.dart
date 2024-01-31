import 'package:finalprojesi/Home.dart';
import 'package:finalprojesi/KayitSayfasi.dart';
import 'package:finalprojesi/Note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FirebaseManager.dart';

class Notlar extends StatefulWidget {
  @override
  _NotlarState createState() => _NotlarState();
}

class _NotlarState extends State<Notlar> {
  final FirebaseManager firebaseManager = FirebaseManager();
  List<Map<String, dynamic>> notlistesi = [];



  @override
  void initState() {
    super.initState();
    _verileriGetir();
  }

  Future<void> _verileriGetir() async {
    List<Map<String, dynamic>> veriler = await firebaseManager.getNotlar();

    setState(() {
      notlistesi = veriler;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false
      ),
      body: ListView.builder(
        itemCount: notlistesi.length,
        itemBuilder: (context, index) {


          var model = Note(
              id: notlistesi[index]['id'] as String,
              title: notlistesi[index]['title'] as String,
              content: notlistesi[index]['content'] as String,

              );


            return Card(
              margin: EdgeInsets.all(5.0),
              child: ListTile(
                title: Text(model.title),
                subtitle: Text('Yazar:${model.content}'),

                leading: Icon(Icons.book),
                onTap: () {

                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(

                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _showAlertDialog(context,index,model);
                      },
                    ),
                  ],
                ),
              ),
            );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KayitSayfasi(

            )),
          );
        },
        child: Icon(Icons.add),
      ),
    );

  }

  void _showAlertDialog(BuildContext context,int index,Note model ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Silme işlemi'),
          content: Text('Kitabı Silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Alert dialogu kapat
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
               // firebaseManager.deleteData(model);
               // kitapListesi.removeAt(index);

                setState(() {

                });
                Navigator.of(context).pop(); // Alert dialogu kapat
              },
              child: Text('Sil'),
            ),
          ],
        );
      },
    );
  }





}