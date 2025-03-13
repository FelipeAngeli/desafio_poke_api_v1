import 'package:desafio_poke_api/controllers/pokemon_controller.dart';
import 'package:desafio_poke_api/views/widget/pokemon_card.dart';
import 'package:flutter/material.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PokemonListViewState createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  late PokemonController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PokemonController();
    _controller.addListener(_onControllerUpdated);
    _loadData();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdated);
    super.dispose();
  }

  void _onControllerUpdated() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadData() async {
    await _controller.loadPokemons();
  }

  void _onSearchChanged(String query) {
    _controller.filterPokemons(query);
  }

  void _onPokemonSelected(String pokemonId, bool isSelected) {
    _controller.toggleSelection(pokemonId, isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémons'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          // Lista de Pokémons
          Expanded(
            child: _controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _controller.filteredPokemons.isEmpty
                    ? const Center(child: Text('No Pokémon found'))
                    : ListView.builder(
                        itemCount: _controller.filteredPokemons.length,
                        itemBuilder: (context, index) {
                          final pokemon = _controller.filteredPokemons[index];
                          final isSelected = _controller.selectedPokemons[pokemon.id] ?? false;
                          return PokemonCard(
                            pokemon: pokemon,
                            selected: isSelected,
                            onSelected: (bool? value) {
                              _onPokemonSelected(pokemon.id, value ?? false);
                            },
                            onTap: () {
                              final newValue = !isSelected;
                              _onPokemonSelected(pokemon.id, newValue);
                              debugPrint('Selected: ${pokemon.name}, ID: ${pokemon.id}');
                            },
                          );
                        },
                      ),
          )
        ],
      ),
    );
  }
}
