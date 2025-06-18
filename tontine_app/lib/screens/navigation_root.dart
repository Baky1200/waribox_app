import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'tontine/tontine_tab_screen.dart';

class NavigationRoot extends StatefulWidget {
  final int initialIndex;

  const NavigationRoot({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _NavigationRootState createState() => _NavigationRootState();
}

class _NavigationRootState extends State<NavigationRoot> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    HomeScreen(),
    TontineTabScreen(),
    Center(child: Text("Coffre Collectif")),
    Center(child: Text("Coffre Individuel")),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // ✅ Initialisation ici
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: "Tontine"),
          BottomNavigationBarItem(icon: Icon(Icons.savings), label: "Collectif"),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Individuel"),
        ],
      ),
    );
  }
}
