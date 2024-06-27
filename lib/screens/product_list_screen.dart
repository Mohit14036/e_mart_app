import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_item.dart';
import '../widgets/product_item.dart';
import 'package:e_mart_app/models/my_product.dart';


class ProductListScreen extends StatelessWidget {
  final String categoryTitle;

  ProductListScreen(this.categoryTitle);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: _buildProducts(categoryTitle),
        ),
      ),

    );

  }Widget _buildProducts(categoryTitle){
    if (categoryTitle == 'Electronics') {
      return _buildElectronicsGrid();
    } else if (categoryTitle == 'Clothing') {
      return _buildClothingGrid();
    } else if (categoryTitle == 'Groceries') {
      return _buildGroceriesGrid();
    } else if (categoryTitle == 'Makeup') {
      return _buildBeautyProductsGrid();
    } else if (categoryTitle == 'Books') {
      return _buildBooksGrid();
    } else {
      return Center(
        child: Text('No products available in this category.'),
      );
    }
  }

  Widget _buildElectronicsGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 100 / 140,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: MyProducts.Electronics.length,
      itemBuilder: (context, index) {
        final featuredProduct = MyProducts.Electronics[index];
        return ProductCard(product: featuredProduct);
      },
    );
  }

  Widget _buildClothingGrid(){
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 100 / 140,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: MyProducts.Clothing.length,
      itemBuilder: (context, index) {
        final featuredProduct = MyProducts.Clothing[index];
        return ProductCard(product: featuredProduct);
      },
    );
  }

  Widget _buildGroceriesGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 100 / 140,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: MyProducts.Groceries.length,
      itemBuilder: (context, index) {
        final featuredProduct = MyProducts.Groceries[index];
        return ProductCard(product: featuredProduct);
      },
    );
  }

  Widget _buildBeautyProductsGrid(){
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 100 / 140,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: MyProducts.Beauty_Products.length,
      itemBuilder: (context, index) {
        final featuredProduct = MyProducts.Beauty_Products[index];
        return ProductCard(product: featuredProduct);
      },
    );
  }


  Widget _buildBooksGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 100 / 140,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: MyProducts.Books.length,
      itemBuilder: (context, index) {
        final featuredProduct = MyProducts.Books[index];
        return ProductCard(product: featuredProduct);
      },
    );
  }
}
