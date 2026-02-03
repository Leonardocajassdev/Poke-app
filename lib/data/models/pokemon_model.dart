import 'package:hive/hive.dart';

part 'pokemon_model.g.dart';

@HiveType(typeId: 0)
class PokemonModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  @HiveField(2)
  final int id;

  @HiveField(3)
  final String? imageUrl;

  @HiveField(4)
  final List<String>? types;

  @HiveField(5)
  final int? height;

  @HiveField(6)
  final int? weight;

  @HiveField(7)
  final List<String>? abilities;

  PokemonModel({
    required this.name,
    required this.url,
    required this.id,
    this.imageUrl,
    this.types,
    this.height,
    this.weight,
    this.abilities,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    // Extraer ID de la URL
    final url = json['url'] as String? ?? '';
    final id = int.tryParse(url.split('/').reversed.skip(1).first) ?? 0;

    return PokemonModel(
      name: json['name'] ?? '',
      url: url,
      id: id,
      imageUrl: id > 0
          ? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png'
          : null,
    );
  }

  factory PokemonModel.fromDetailJson(Map<String, dynamic> json) {
    final id = json['id'] ?? 0;
    final types = (json['types'] as List?)
        ?.map((t) => t['type']['name'] as String)
        .toList() ?? [];
    
    final abilities = (json['abilities'] as List?)
        ?.map((a) => a['ability']['name'] as String)
        .toList() ?? [];

    return PokemonModel(
      name: json['name'] ?? '',
      url: '',
      id: id,
      imageUrl: json['sprites']?['other']?['official-artwork']?['front_default'],
      types: types,
      height: json['height'],
      weight: json['weight'],
      abilities: abilities,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'id': id,
      'imageUrl': imageUrl,
      'types': types,
      'height': height,
      'weight': weight,
      'abilities': abilities,
    };
  }

  String get capitalizedName {
    return name.isEmpty ? '' : name[0].toUpperCase() + name.substring(1);
  }

  String get displayHeight {
    if (height == null) return 'N/A';
    return '${(height! / 10).toStringAsFixed(1)} m';
  }

  String get displayWeight {
    if (weight == null) return 'N/A';
    return '${(weight! / 10).toStringAsFixed(1)} kg';
  }
}
