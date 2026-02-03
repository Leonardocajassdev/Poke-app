import 'package:get/get.dart';
import '../../data/models/pokemon_model.dart';
import '../../data/repositories/pokemon_repository.dart';

class PokemonDetailController extends GetxController {
  final PokemonRepository _repository = PokemonRepository();

  final pokemon = Rx<PokemonModel?>(null);
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final PokemonModel? initialPokemon = Get.arguments;
    if (initialPokemon != null) {
      pokemon.value = initialPokemon;
      loadPokemonDetail(initialPokemon.id);
    }
  }

  // Cargar detalles completos del Pokémon
  Future<void> loadPokemonDetail(int id) async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final details = await _repository.getPokemonDetail(id);
      pokemon.value = details;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Error al cargar detalles: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  // Obtener color según el tipo de Pokémon
  int getTypeColor(String? type) {
    if (type == null) return 0xFF78C850;
    
    switch (type.toLowerCase()) {
      case 'grass':
        return 0xFF78C850;
      case 'fire':
        return 0xFFF08030;
      case 'water':
        return 0xFF6890F0;
      case 'electric':
        return 0xFFF8D030;
      case 'ice':
        return 0xFF98D8D8;
      case 'fighting':
        return 0xFFC03028;
      case 'poison':
        return 0xFFA040A0;
      case 'ground':
        return 0xFFE0C068;
      case 'flying':
        return 0xFFA890F0;
      case 'psychic':
        return 0xFFF85888;
      case 'bug':
        return 0xFFA8B820;
      case 'rock':
        return 0xFFB8A038;
      case 'ghost':
        return 0xFF705898;
      case 'dragon':
        return 0xFF7038F8;
      case 'dark':
        return 0xFF705848;
      case 'steel':
        return 0xFFB8B8D0;
      case 'fairy':
        return 0xFFEE99AC;
      default:
        return 0xFF68A090;
    }
  }
}
