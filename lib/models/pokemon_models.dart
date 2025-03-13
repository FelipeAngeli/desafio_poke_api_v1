class PokemonModels {
  final String name;
  final String url;
  final int? height;
  final int? wigth;
  final int? baseExperience;

  PokemonModels({
    required this.name,
    required this.url,
    this.height,
    this.wigth,
    this.baseExperience,
  });

  factory PokemonModels.fromJson(Map<String, dynamic> json) {
    return PokemonModels(
      name: json['name'],
      url: json['url'],
      height: json['height'],
      wigth: json['wigth'],
      baseExperience: json['base_experience'],
    );
  }

  factory PokemonModels.fromDetailJson(Map<String, dynamic> json, String summaryUrl) {
    return PokemonModels(
      name: json['name'] as String,
      url: summaryUrl,
      height: json['height'] as int,
      wigth: json['weight'] as int,
      baseExperience: json['base_experience'] as int,
    );
  }

  String get id {
    final segments = Uri.parse(url).pathSegments.where((segment) => segment.isNotEmpty).toList();
    return segments.isNotEmpty ? segments.last : '';
  }

  String get imageUrl => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
}
