import 'package:e_mart_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key,required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {

    final provider = CartProvider.of(context);
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
              children: [GestureDetector(
                  onTap: ()=> provider.toggleFavorite(widget.product),
                  child: Icon(
                    provider.isExist(widget.product)
                    ?Icons.favorite
                    :Icons.favorite_border_outlined,color: Colors.red,))
              ],
            ),
            SizedBox(
              height: 129,
              width: 130,
              child:Image.asset(widget.product.imageUrl,
              fit:BoxFit.cover)
            ),
            Text(widget.product.title,style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),),
            Text(widget.product.category,style: const TextStyle(
              fontSize: 14,
            ),),
            Text('\$' '${widget.product.price}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
      ),
    );
  }
}
