import 'package:flutter/material.dart';
import 'package:out_app/user_side/bookings_body/bookings_body.dart';
import 'package:out_app/user_side/home_body/home_body.dart';
import 'package:out_app/user_side/saved_body/saved_body.dart';
import 'package:out_app/user_side/search_body/search_body.dart';
import 'package:out_app/user_side/settings_body/settings_body.dart';

class BusHomeScreen extends StatefulWidget {
  const BusHomeScreen({Key? key}) : super(key: key);

  @override
  _BusHomeScreenState createState() => _BusHomeScreenState();
}

class _BusHomeScreenState extends State<BusHomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    SearchBody(),
    SavedBody(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> outNavigationBar() {
    List<BottomNavigationBarItem> bottomNavigationBar = [];

    bottomNavigationBar.add(const BottomNavigationBarItem(
      label: 'Bookings',
      icon: Icon(Icons.book),
    ));
    bottomNavigationBar.add(const BottomNavigationBarItem(
      label: 'Business',
      icon: Icon(Icons.business),
    ));

    return bottomNavigationBar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          ...outNavigationBar(),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF1C2678),
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: const Color(0x99FFFFFF),
      ),
    );
  }
}
