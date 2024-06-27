import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_items_provider.dart';
import 'package:e_mart_app/models/product.dart';
import 'package:e_mart_app/screens/cart_screen.dart';
import 'package:e_mart_app/widgets/avaliable_option.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  Widget _buildAvailableOptions(Product product) {
    switch (product.category) {
      case 'electronics':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            const Text(
              "Available Options",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                AvaliableOption(option: '128GB'),
                AvaliableOption(option: '256GB'),
              ],
            ),
            const SizedBox(height: 8.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Avaliable Colors",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),)
              ],
            ),
            const SizedBox(height: 8.0,),
            Row(
              children: const[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.black,
                ),
                SizedBox(width: 8.0,),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.green,
                ),
                SizedBox(width: 8.0,),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
          ],
        );
      case 'clothes':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            const Text(
              "Available Options",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                AvaliableOption(option: 'XL'),
                AvaliableOption(option: 'L'),
                AvaliableOption(option: 'M'),
              ],
            ),
            const SizedBox(height: 8.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Avaliable Colors",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),)
              ],
            ),
            const SizedBox(height: 8.0,),
            Row(
              children: const[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.green,
                ),
                SizedBox(width: 8.0,),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.red,
                ),
                SizedBox(width: 8.0,),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.brown,
                ),
                SizedBox(width: 8.0,),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.black,
                ),
                SizedBox(width: 8.0,),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                ),
              ],
            ),

          ],
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartItemsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade100,
                  ),
                  child: Image.asset(product.imageUrl, fit: BoxFit.cover),
                )
              ],
            ),
            const SizedBox(height: 36),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    product.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 14),
                  ),
                  _buildAvailableOptions(product),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  provider.toggleProduct(product);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
