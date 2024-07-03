import 'package:e_mart_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';
import 'package:e_mart_app/services/user_service.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final UserService _userService = UserService();
  late Future<bool> _isFavoriteFuture;

  @override
  void initState() {
    super.initState();
    _isFavoriteFuture = _userService.isFavorite(widget.product.title);
  }

  Future<void> _toggleFavorite() async {
    final isFavorite = await _isFavoriteFuture;
    if (isFavorite) {
      await _userService.removeFromFavorites(widget.product);
    } else {
      await _userService.addToFavorites(widget.product);
    }
    setState(() {
      _isFavoriteFuture = _userService.isFavorite(widget.product.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);

    return FutureBuilder<bool>(
      future: _isFavoriteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          bool isFavorite = snapshot.data ?? false;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: widget.product),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _toggleFavorite();
                          provider.toggleFavorite(widget.product);
                          setState(() {});
                        },
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 129,
                    width: 130,
                    child: Image.asset(widget.product.imageUrl, fit: BoxFit.cover),
                  ),
                  Text(
                    widget.product.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.product.category,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    '\$${widget.product.price}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
