import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/cart.dart';
import 'package:provider_test/saved_notifier.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SavedNotifier>(
      create: ((context) => SavedNotifier()),
      child: MaterialApp(
        home: RandomWords(),
      ),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = generateWordPairs().take(30).toList();

  Widget _buildSuggestions() {
    Iterable<Widget> tiles =
        _suggestions.map((wordPair) => _buildRow(wordPair));
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[];

    return ListView(
      padding: EdgeInsets.all(16.0),
      children: divided,
    );
  }

  Widget _buildRow(WordPair pair) {
    //빌드 context에 접근 여부에 따라 크게 2가지 방법이 있음
    // 지금은 어렵다고 가정
    return Consumer<SavedNotifier>(
      builder: (context, savedNotifier, child) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
          ),
          trailing: Icon(
            savedNotifier.alreadyContain(pair)
                ? Icons.favorite
                : Icons.favorite_border,
            color: savedNotifier.alreadyContain(pair) ? Colors.red : null,
          ),
          onTap: () {
            // setState(() {
            //   if (alreadySaved) {
            //     saved.remove(pair);
            //   } else {
            //     saved.add(pair);
            //   }
            savedNotifier.toggleSaved(pair);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Cart();
        },
      ),
    );
    setState(() {});
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<RandomWords> createState() => _RandomWordsState();
}
