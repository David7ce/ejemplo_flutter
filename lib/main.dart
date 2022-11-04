import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Generador de nombres en inglés',
        home: RandomWords(),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  final suggestions = <WordPair>[];
  final saved = <WordPair>[];
  final biggerFont = const TextStyle(fontSize: 18);

  void _pushSaved() {}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Generador de nombres"),
        actions: [
          IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved, tooltip: "Ver palabras guardadas")
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;

          if (index >= suggestions.length) {
            suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadySaved = saved.contains(suggestions[index]);

          return ListTile(
              title: Text(
                suggestions[index].asCamelCase,
                style: biggerFont,
              ),
              trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
                semanticLabel: alreadySaved ? "Quitar guardado" : "Guardar",
              ),
              onTap: (() {
                // setState() configura el estado
                setState(() {
                  if (alreadySaved) {
                    saved.remove(suggestions[index]);
                  } else {
                    saved.add(suggestions[index]);
                  }
                });
              }));
        })
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}
