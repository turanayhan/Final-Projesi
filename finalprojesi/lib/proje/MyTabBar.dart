import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Toplam 3 sekme
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar Örneği'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Sekme 1'),
            Tab(text: 'Sekme 2'),
            Tab(text: 'Sekme 3'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Sekme 1 içeriği
          Center(child: Text('İçerik 1')),
          // Sekme 2 içeriği
          Center(child: Text('İçerik 2')),
          // Sekme 3 içeriği
          Center(child: Text('İçerik 3')),
        ],
      ),
    );
  }
}
