class AppConstants {
  // API
  static const String apiBaseUrl = 'https://pokeapi.co/api/v2';
  static const int pokemonLimit = 151; // Primera generación
  
  // Hive Boxes
  static const String pokemonBox = 'pokemon';
  static const String sessionBox = 'session';
  
  // Routes
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String detailRoute = '/pokemon-detail';
  
  // Firebase
  static const int minPasswordLength = 6;
  
  // UI
  static const int gridColumns = 2;
  static const double cardAspectRatio = 0.85;
}
