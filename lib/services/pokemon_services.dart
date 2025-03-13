import 'dart:convert';
import 'package:desafio_poke_api/exceptions/pokemon_exceptions.dart';
import 'package:desafio_poke_api/models/pokemon_models.dart';
import 'package:http/http.dart' as http;

class PokemonService {
  static const _baseDomain = 'pokeapi.co';
  static const _pokemonListPath = 'api/v2/pokemon';
  static const _defaultLimit = 50;

  final http.Client _client;

  PokemonService({http.Client? client}) : _client = client ?? http.Client();

  Uri _buildPokemonListUri() => Uri.https(
        _baseDomain,
        _pokemonListPath,
        {'limit': _defaultLimit.toString()},
      );

  Future<List<PokemonModels>> fetchPokemonList() async {
    try {
      final response = await _client.get(_buildPokemonListUri());

      if (response.statusCode != 200) {
        throw PokemonException('Unexpected API response status: ${response.statusCode}');
      }

      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> results = data['results'];

      final futures = results.map<Future<PokemonModels>>((json) async {
        final summary = PokemonModels.fromSummaryJson(json as Map<String, dynamic>);
        try {
          return await _fetchPokemonDetails(summary);
        } catch (_) {
          return summary;
        }
      }).toList();

      return await Future.wait(futures);
    } catch (e) {
      throw PokemonException('Failed to load Pokémon list', e);
    }
  }

  Future<PokemonModels> _fetchPokemonDetails(PokemonModels summary) async {
    try {
      final response = await _client.get(Uri.parse(summary.url));
      if (response.statusCode == 200) {
        final detailJson = jsonDecode(response.body) as Map<String, dynamic>;
        return PokemonModels.fromDetailJson(detailJson, summary.url);
      }
      return summary;
    } catch (_) {
      return summary;
    }
  }
}
