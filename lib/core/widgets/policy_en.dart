import 'package:flutter/material.dart';
import 'package:insuranceapp/features/travel/pages/book_mark.dart';
import 'package:insuranceapp/features/travel/pages/place.dart';
import 'package:insuranceapp/features/travel/pages/popular_place.dart';

class MyTabPage extends StatefulWidget {
  @override
  _MyTabPageState createState() => _MyTabPageState();
}

class _MyTabPageState extends State<MyTabPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    // Center(child: Text('Home Page')),
    // Center(child: Text('Place')),
    // Center(child: Text('BookMark')),
    PopularPlace(),
    Place(),
    BookMark(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop),
            label: 'Place',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'BookMark',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
        backgroundColor: Colors.green[900],
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(size: 30, color: Colors.red),
        unselectedIconTheme: IconThemeData(size: 20, color: Colors.white70),
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
    );
  }
}
