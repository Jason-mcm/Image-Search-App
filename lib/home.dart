import 'package:flutter/material.dart';
import 'search.dart';
import 'photo.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart'; // Import the package

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final Search _search = Search();
  List<Photo> _photos = [];
  bool _isLoading = false;
  final Set<int> _liked = {};

  void searchQuery(String query) async {
    setState(() {
      _isLoading = true;
    });
    final result = await _search.search(query);
    setState(() {
      _photos = result;
      _isLoading = false;
    });
  }

  void toggleLike(int photoId) {
    setState(() {
      if (_liked.contains(photoId)) {
        _liked.remove(photoId);
      } else {
        _liked.add(photoId);
      }
    });
    print(_liked.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
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
                            if (_liked.contains(photo.id)) {
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
                                        )),

                                    IconButton(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      icon: Icon(icon),
                                      tooltip: 'Like',
                                      iconSize: 30,
                                      onPressed: () {
                                        toggleLike(photo.id);
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
