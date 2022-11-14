import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/main.dart';
import 'package:provider_test/saved_notifier.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final savedNotifier = context.watch<SavedNotifier>();
    final tiles = savedNotifier.saved.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
          ),
          onTap: (() {
            // setState(() {
            //   saved.remove(pair);
            // });
            savedNotifier.toggleSaved(pair);
          }),
        );
      },
    );

    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[];
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ), // Appar
      body: ListView(children: divided),
    );
  }
}
