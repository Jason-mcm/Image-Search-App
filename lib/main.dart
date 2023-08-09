/// Jason McMillan

import 'package:flutter/material.dart';
import 'package:image_search/photoProvider.dart';
import 'package:provider/provider.dart';
import 'home.dart';

/// Main driver function
void main() {
  runApp(
      ChangeNotifierProvider(create: (context) => LikedPhotosProvider(),
      child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Search App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade500),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Image Search App'),
    );
  }
}


