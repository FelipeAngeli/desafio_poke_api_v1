import 'package:desafio_poke_api/models/pokemon_models.dart';
import 'package:desafio_poke_api/services/pokemon_services.dart';
import 'package:flutter/material.dart';

class PokemonController extends ChangeNotifier {
  final PokemonService _service;

  List<PokemonModels> allPokemons = [];
  List<PokemonModels> filteredPokemons = [];
  Map<String, bool> selectedPokemons = {};
  bool isLoading = true;

  PokemonController({PokemonService? service}) : _service = service ?? PokemonService();

  Future<void> loadPokemons() async {
    try {
      allPokemons = await _service.fetchPokemonList();
      filteredPokemons = List<PokemonModels>.from(allPokemons);
      selectedPokemons = {for (var pokemon in allPokemons) pokemon.id: false};
    } catch (e) {
      debugPrint('Erro ao carregar Pokémon: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterPokemons(String query) {
    if (query.isEmpty) {
      filteredPokemons = List<PokemonModels>.from(allPokemons);
    } else {
      filteredPokemons =
          allPokemons.where((pokemon) => pokemon.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }

  void toggleSelection(String pokemonId, bool isSelected) {
    selectedPokemons[pokemonId] = isSelected;
    notifyListeners();
  }
}
