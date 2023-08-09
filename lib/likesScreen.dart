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
    likedPhotos = likedPhotos.reversed.toList();

    return Scaffold(
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: likedPhotos.length,
          itemBuilder: (context, index) {
            final photo = likedPhotos[index];
            return Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        height: 175,
                        width: 200,
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