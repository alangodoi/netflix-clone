import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w300, fontFamily: 'Comfortaa');
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Início',
      style: optionStyle,
    ),
    Text(
      'Index 1: Buscas',
      style: optionStyle,
    ),
    Text(
      'Index 2: Breve',
      style: optionStyle,
    ),
    Text(
      'Index 3: Downloads',
      style: optionStyle,
    ),
    Text(
      'Index 4: Mais',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type : BottomNavigationBarType.fixed,        
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Início'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Buscas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            title: Text('Em breve'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_downward),
            title: Text('Downloads'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            title: Text('Em breve'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xff0f0f0f),
        unselectedItemColor: Colors.grey,
        // fixedColor: Colors.grey,

        onTap: _onItemTapped,
      );
  }
}