/// Jason McMillan

import 'package:flutter/material.dart';
import 'package:image_search/photoProvider.dart';
import 'package:provider/provider.dart';
import 'photo.dart';

/// Like screen widget
class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    final likedPhotoProvider = Provider.of<LikedPhotosProvider>(context);
    List<Photo> likedPhotos = likedPhotoProvider.likedPhotos.toList();

    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: likedPhotos.length,
          itemBuilder: (context, index) {
            final photo = likedPhotos[index];
            return Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        height: 300,
                        width: 375,
                        child: Image.network(
                          photo.url,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },
                        )
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}