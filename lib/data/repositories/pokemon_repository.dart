import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../models/pokemon_model.dart';

class PokemonRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://pokeapi.co/api/v2',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  final Box<PokemonModel> _pokemonBox = Hive.box<PokemonModel>('pokemon');

  // Obtener lista de Pokémon desde API o cache
  Future<List<PokemonModel>> getPokemonList({int limit = 151}) async {
    try {
      // Verificar si hay datos en cache
      if (_pokemonBox.isNotEmpty) {
        return _pokemonBox.values.toList();
      }

      // Si no hay cache, obtener de la API
      final response = await _dio.get('/pokemon', queryParameters: {
        'limit': limit,
      });

      final List results = response.data['results'];
      final List<PokemonModel> pokemonList = [];

      for (var pokemon in results) {
        final pokemonModel = PokemonModel.fromJson(pokemon);
        pokemonList.add(pokemonModel);
        
        // Guardar en cache si no existe
        if (!_pokemonBox.containsKey(pokemonModel.id)) {
          await _pokemonBox.put(pokemonModel.id, pokemonModel);
        }
      }

      return pokemonList;
    } catch (e) {
      // Si hay error y tenemos cache, devolver cache
      if (_pokemonBox.isNotEmpty) {
        return _pokemonBox.values.toList();
      }
      rethrow;
    }
  }

  // Obtener detalles de un Pokémon específico
  Future<PokemonModel> getPokemonDetail(int id) async {
    try {
      final response = await _dio.get('/pokemon/$id');
      final pokemonDetail = PokemonModel.fromDetailJson(response.data);
      
      // Actualizar en cache
      await _pokemonBox.put(id, pokemonDetail);
      
      return pokemonDetail;
    } catch (e) {
      // Si hay error, devolver desde cache si existe
      final cached = _pokemonBox.get(id);
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  // Buscar Pokémon por nombre
  List<PokemonModel> searchPokemon(String query) {
    if (query.isEmpty) {
      return _pokemonBox.values.toList();
    }

    return _pokemonBox.values
        .where((pokemon) =>
            pokemon.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Limpiar cache
  Future<void> clearCache() async {
    await _pokemonBox.clear();
  }

  // Verificar si hay datos en cache
  bool hasCache() {
    return _pokemonBox.isNotEmpty;
  }
}
