/// Jason McMillan

import 'package:flutter/material.dart';
import 'package:image_search/photoProvider.dart';
import 'search.dart';
import 'photo.dart';
import 'debouncer.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Search _search = Search();
  List<Photo> _photos = [];
  bool _isLoading = false;
  final _debouncer = Debouncer(milliSec: 500);

  /// API call to return list of photos based on input query
  void searchQuery(String query) async {
    if (query.isEmpty) {
      setState(() {
        _photos.clear();
      });
      return;
    }

    // Prevent excess api calls
    _debouncer.debounce(() async {
      setState(() {
        _isLoading = true;
      });
      final result = await _search.search(query);
      setState(() {
        _photos = result;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final likedPhotosProvider = Provider.of<LikedPhotosProvider>(context);
    Set<int> photoIds = likedPhotosProvider.photoIds;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                  hintText: 'Search...', prefixIcon: Icon(Icons.search)),
              onChanged: (query) {
                searchQuery(query);
              },
            ),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _photos.isEmpty
                      ? const Center(
                          child: Text('No Results Found'),
                        )
                      : ListView.builder(
                          itemCount: _photos.length,
                          itemBuilder: (context, index) {
                            final photo = _photos[index];
                            IconData icon;
                            if (photoIds.contains(photo.id)) {
                              icon = Icons.favorite;
                            } else {
                              icon = Icons.favorite_border;
                            }
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
                                        )),
                                    IconButton(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      icon: Icon(icon),
                                      tooltip: 'Like',
                                      iconSize: 30,
                                      onPressed: () {
                                        likedPhotosProvider.toggleLike(photo);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            )
          ],
        ),
      ),
    );
  }
}
