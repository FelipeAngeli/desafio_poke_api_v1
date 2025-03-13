class PokemonException implements Exception {
  final String message;
  final dynamic cause;

  PokemonException(this.message, [this.cause]);

  @override
  String toString() => 'PokemonServiceException: $message${cause != null ? '. Cause: $cause' : ''}';
}
