import 'package:desafio_poke_api/models/pokemon_models.dart';
import 'package:desafio_poke_api/utils/type_colors.dart';
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

  Color get _cardColor {
    if (pokemon.types.isNotEmpty) {
      final primaryType = pokemon.types.first.toLowerCase();
      return TypeColors.colors[primaryType] ?? Colors.white;
    }
    return Colors.white;
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Altura: ${pokemon.height ?? 'Altura'}'),
        Text('Peso: ${pokemon.weight ?? 'Peso'}'),
        Text('Experiência: ${pokemon.baseExperience ?? 'Experiência'}'),
        Text('Categoria: ${pokemon.types.isNotEmpty ? pokemon.types.join(', ') : 'Categoria'}'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _cardColor.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        leading: SizedBox(
          width: 64,
          height: 64,
          child: Image.network(
            pokemon.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          ),
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
