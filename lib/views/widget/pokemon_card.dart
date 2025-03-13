import 'package:desafio_poke_api/models/pokemon_models.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModels pokemon;
  final bool selected;
  final ValueChanged<bool?>? onSelected;
  final VoidCallback? onTap;

  const PokemonCard({
    Key? key,
    required this.pokemon,
    this.selected = false,
    this.onSelected,
    this.onTap,
  }) : super(key: key);

  String get _formattedName {
    if (pokemon.name.isEmpty) return pokemon.name;
    return '${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}';
  }

  _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Altura: ${pokemon.height ?? 'Altura'}'),
        Text('Peso: ${pokemon.weight ?? 'Peso'}'),
        Text('Experiência: ${pokemon.baseExperience ?? 'Experiência'}'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        leading: Image.network(
          pokemon.imageUrl,
          width: 64,
          height: 64,
          fit: BoxFit.cover,
        ),
        title: Text(
          _formattedName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: _buildDetails(),
        trailing: Checkbox(
          value: selected,
          onChanged: onSelected,
        ),
        onTap: onTap,
      ),
    );
  }
}
