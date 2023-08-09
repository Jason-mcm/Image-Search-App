import 'package:flutter/material.dart';
import 'search.dart';
import 'photo.dart';
import 'searchScreen.dart';
import 'likesScreen.dart';

// import 'package:flutter_cache_manager/flutter_cache_manager.dart'; // Import the package

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const SearchScreen(),
    LikesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo App'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // ... (bottom navigation bar code)
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
      BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.favorite),
    label: 'Favorites',
      ),
    ]));
  }
}
