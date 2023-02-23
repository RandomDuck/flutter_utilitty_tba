import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/state.dart';

class FavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text('Favorites:'),
        SizedBox(
          height: 20,
        ),
        for (var fav in appState.favorites)
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ElevatedButton.icon(
              onPressed: () {
                appState.toggleFavorite(fav);
              },
              icon: Icon(Icons.favorite),
              label: Text(
                fav.asLowerCase,
                semanticsLabel: fav.asPascalCase,
              ),
            ),
          ),
      ],
    );
  }
}
