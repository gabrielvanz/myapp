import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true,
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          if (favoriteProvider.favorites.isEmpty) {
            return const Center(
              child: Text(
                'Você não tem produtos favoritos',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 5,
            ),
            itemCount: favoriteProvider.favorites.length,
            itemBuilder: (context, index) {
              final product = favoriteProvider.favorites[index];
              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
} 