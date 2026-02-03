import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../data/models/pokemon_model.dart';
import '../../data/repositories/pokemon_repository.dart';

class HomeController extends GetxController {
  final PokemonRepository _repository = PokemonRepository();

  // Estados observables
  final pokemonList = <PokemonModel>[].obs;
  final filteredPokemonList = <PokemonModel>[].obs;
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  final isOffline = false.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
    loadPokemon();
  }

  // Verificar conectividad
  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    isOffline.value = connectivityResult == ConnectivityResult.none;
    
    // Escuchar cambios en la conectividad
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isOffline.value = result == ConnectivityResult.none;
    });
  }

  // Cargar lista de Pokémon
  Future<void> loadPokemon() async {
    if (isLoading.value) return;

    isLoading.value = true;
    hasError.value = false;

    try {
      final pokemon = await _repository.getPokemonList();
      pokemonList.value = pokemon;
      filteredPokemonList.value = pokemon;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Error al cargar datos: ${e.toString()}';
      
      // Si hay cache, mostrar mensaje informativo
      if (_repository.hasCache()) {
        errorMessage.value = 'Mostrando datos guardados (sin conexión)';
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Buscar Pokémon
  void searchPokemon(String query) {
    searchQuery.value = query;
    
    if (query.isEmpty) {
      filteredPokemonList.value = pokemonList;
    } else {
      filteredPokemonList.value = _repository.searchPokemon(query);
    }
  }

  // Limpiar búsqueda
  void clearSearch() {
    searchQuery.value = '';
    filteredPokemonList.value = pokemonList;
  }

  // Recargar datos
  Future<void> refreshPokemon() async {
    await _repository.clearCache();
    await loadPokemon();
  }

  // Verificar si hay datos en cache
  bool hasCache() {
    return _repository.hasCache();
  }
}
