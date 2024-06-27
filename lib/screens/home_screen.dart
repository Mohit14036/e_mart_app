// lib/screens/home_screen.dart
import 'package:e_mart_app/models/my_product.dart';
import 'package:e_mart_app/screens/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';
import '../screens/product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside the search bar
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
            title: Text('ShopEase'),
            centerTitle: true,
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                  bottom: 8.0), // Adjust the padding to move the AppBar down
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip(context, 'Electronics', 'images/phone.png'),
                    _buildCategoryChip(context, 'Clothing', 'images/clothes.png'),
                    _buildCategoryChip(context, 'Groceries', 'images/grocery.png'),
                    _buildCategoryChip(context, 'Makeup', 'images/beauty.png'),
                    _buildCategoryChip(context, 'Books', 'images/books.png'),
                    // Add more categories as needed
                  ],
                ),
              ),
              SizedBox(height: 16.0), // Add spacing between category chips and featured items
              Text(
                'Featured Items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27.0,
                ),
              ),
              SizedBox(height: 8.0),
              // Featured products section
              Expanded(
                child: _buildFeaturedProducts(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedProducts() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 100 / 140,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: MyProducts.feautered_items.length,
      itemBuilder: (context, index) {
        final featuredProduct = MyProducts.feautered_items[index];
        return GestureDetector(
          onTap: ()=>Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>ProductDetailScreen(product:featuredProduct))
          ),
            child:ProductCard(product: featuredProduct),
        );
        },
    );
  }

  Widget _buildCategoryChip(BuildContext context, String categoryName, String imagePath) {
    return GestureDetector(
      onTap: () {
        // Navigate to the product list screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductListScreen(categoryName),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(2.0), // Border width
              decoration: BoxDecoration(
                color: Colors.white, // Border color
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              child: CircleAvatar(
                radius: 30, // Adjust the size of the circle
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              categoryName,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
