import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/prvoider/favorites_provider.dart';
import 'package:testing_app/view/favorites_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Sample'),
        actions:[
          TextButton.icon(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesPage())),
            icon: const Icon(Icons.favorite_border),
            label: const Text('Favorites')
          )
        ]
      ),
      body: ListView.builder(
        itemCount: 100,
        cacheExtent: 20.0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => ItemTile(itemNo: index)
      )
    );
  }
}

class ItemTile extends StatelessWidget {
  final int itemNo;
  const ItemTile({Key? key,required this.itemNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<FavoritesPovider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length]
        ),
        title: Text(
          'Item $itemNo',
          key: Key('text_$itemNo')
        ),
        trailing: IconButton(
          key: Key('icon_$itemNo'),
          icon: favoritesList.items.contains(itemNo)
              ? const Icon(Icons.favorite,color: Colors.red)
              : const Icon(Icons.favorite_border),
          onPressed: () {
            !favoritesList.items.contains(itemNo)
            ? favoritesList.add(itemNo)
            : favoritesList.remove(itemNo);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(favoritesList.items.contains(itemNo)
                ? 'Added to favorites.'
                : 'Removed from favorites.'),
                duration: const Duration(seconds: 1)
              )
            );
          }
        )
      )
    );
  }
}
