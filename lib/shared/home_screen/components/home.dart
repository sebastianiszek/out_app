import 'package:flutter/material.dart';
import 'package:out_app/user_side/bookings_body/bookings_body.dart';
import 'package:out_app/user_side/home_body/home_body.dart';
import 'package:out_app/user_side/saved_body/saved_body.dart';
import 'package:out_app/user_side/search_body/search_body.dart';
import 'package:out_app/user_side/settings_body/settings_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;

  static const List<Widget> _widgetOptions = <Widget>[
    SearchBody(),
    SavedBody(),
    HomeBody(),
    BookingsBody(),
    SettingsBody(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> outNavigationBar() {
    List<BottomNavigationBarItem> bottomNavigationBar = [];

    bottomNavigationBar.add(const BottomNavigationBarItem(
      label: 'Search',
      icon: Icon(Icons.search),
    ));
    bottomNavigationBar.add(const BottomNavigationBarItem(
      label: 'Saved',
      icon: Icon(Icons.bookmark),
    ));
    bottomNavigationBar.add(const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home),
    ));
    bottomNavigationBar.add(const BottomNavigationBarItem(
      label: 'Bookings',
      icon: Icon(Icons.calendar_today),
    ));
    bottomNavigationBar.add(const BottomNavigationBarItem(
      label: 'Settings',
      icon: Icon(Icons.settings),
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
