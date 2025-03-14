class PokemonModels {
  final String name;
  final String url;
  final int? height;
  final int? weight;
  final int? baseExperience;

  PokemonModels({
    required this.name,
    required this.url,
    this.height,
    this.weight,
    this.baseExperience,
  });

  factory PokemonModels.fromSummaryJson(Map<String, dynamic> json) {
    return PokemonModels(
      name: json['name'] as String,
      url: json['url'] as String,
      height: null,
      weight: null,
      baseExperience: null,
    );
  }

  factory PokemonModels.fromDetailJson(Map<String, dynamic> json, String summaryUrl) {
    return PokemonModels(
      name: json['name'] as String,
      url: summaryUrl,
      height: json['height'] as int,
      weight: json['weight'] as int,
      baseExperience: json['base_experience'] as int,
    );
  }

  String get id {
    final segments = Uri.parse(url).pathSegments.where((segment) => segment.isNotEmpty).toList();
    return segments.isNotEmpty ? segments.last : '';
  }

  String get imageUrl => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
}
