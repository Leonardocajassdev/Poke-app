import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/pokemon_detail_controller.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PokemonDetailController controller = Get.put(PokemonDetailController());

    return Scaffold(
      body: Obx(() {
        final pokemon = controller.pokemon.value;
        
        if (pokemon == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final primaryType = pokemon.types?.first ?? 'normal';
        final typeColor = Color(controller.getTypeColor(primaryType));

        return CustomScrollView(
          slivers: [
            // App Bar con imagen del Pokémon
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: typeColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  pokemon.capitalizedName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 3,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
                background: pokemon.imageUrl != null
                    ? Hero(
                        tag: 'pokemon-${pokemon.id}',
                        child: CachedNetworkImage(
                          imageUrl: pokemon.imageUrl!,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.catching_pokemon,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.catching_pokemon,
                        size: 100,
                        color: Colors.white,
                      ),
              ),
            ),

            // Contenido
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Número de Pokédex
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '#${pokemon.id.toString().padLeft(3, '0')}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Tipos
                      if (pokemon.types != null && pokemon.types!.isNotEmpty) ...[
                        Text(
                          'Tipos',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: pokemon.types!.map((type) {
                            return Chip(
                              label: Text(
                                type.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Color(
                                controller.getTypeColor(type),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Información física
                      Text(
                        'Información',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem(
                                context,
                                'Altura',
                                pokemon.displayHeight,
                                Icons.height,
                              ),
                              const VerticalDivider(),
                              _buildStatItem(
                                context,
                                'Peso',
                                pokemon.displayWeight,
                                Icons.monitor_weight,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Habilidades
                      if (pokemon.abilities != null &&
                          pokemon.abilities!.isNotEmpty) ...[
                        Text(
                          'Habilidades',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: pokemon.abilities!.map((ability) {
                            return Chip(
                              avatar: const Icon(
                                Icons.stars,
                                size: 16,
                                color: Colors.amber,
                              ),
                              label: Text(
                                ability.replaceAll('-', ' ').toUpperCase(),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ]),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Theme.of(context).primaryColor),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
