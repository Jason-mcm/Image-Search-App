import 'package:flutter/material.dart';
import 'photo.dart';

class LikedPhotosProvider with ChangeNotifier {
  final Set<Photo> _likedPhotos = {};
  final Set<int> _photoIds = {};
  Set<Photo> get likedPhotos => _likedPhotos;
  Set<int> get photoIds => _photoIds;

  void toggleLike(Photo photo) {
    if (_photoIds.contains(photo.id)) {
      _photoIds.remove(photo.id);
      _likedPhotos.remove(photo);
    }
    else {
      _photoIds.add(photo.id);
      _likedPhotos.add(photo);
    }
    notifyListeners();
  }
}