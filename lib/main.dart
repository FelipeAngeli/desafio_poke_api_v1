import 'package:desafio_poke_api/views/pokemon_llist_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const PokemonApp(),
  );
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PokemonListView(),
    );
  }
}
