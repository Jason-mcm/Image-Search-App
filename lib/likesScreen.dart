
import 'package:flutter/material.dart';
import 'package:image_search/photoProvider.dart';
import 'package:provider/provider.dart';


class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    final likedPhotoProvider = Provider.of<LikedPhotosProvider>(context);
    print(likedPhotoProvider.likedPhotos.length);
    return Scaffold(
      body: Center(
        child: Text("HERE hahahahaha"),
      ),
    );
  }
}