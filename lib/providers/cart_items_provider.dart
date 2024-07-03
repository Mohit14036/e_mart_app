import 'package:flutter/cupertino.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
class CartItemsProvider extends ChangeNotifier {
  List<Product> _cart = [];

  List<Product> get cart => _cart;

  void setCartItems(List<Product> cartItems) {
    _cart = cartItems;
    notifyListeners();
  }

  void toggleProduct(Product product) {
    // Check if the product is already in the cart
    final index = _cart.indexWhere((element) => element.title == product.title);

    if (index >=0) {
      // If the product exists, increment its quantity
      _cart[index].quantity++;
    } else {
      // Otherwise, add the product to the cart with quantity 1
      _cart.add(product);
    }

    // Notify listeners that the cart has been updated
    notifyListeners();
  }

  void incrementQuantity(int index) {
    // Increment the quantity of a product at a specific index in the cart

      _cart[index].quantity++;
      notifyListeners();

  }

  void decrementQuantity(int index) {
    // Decrement the quantity of a product at a specific index in the cart

      if (_cart[index].quantity > 1) {
        _cart[index].quantity--;

      }else {
        _cart.removeAt(index);
      }
      notifyListeners();
  }

  double getTotalPrice() {
    // Calculate the total price of all products in the cart
    double total = 0.0;
    for (Product element in _cart) {
      total += element.price * element.quantity;
    }
    return total;
  }


  void removeProduct(Product product) {
    // Remove a product from the cart
    _cart.removeWhere((element) => element.title == product.title);
    notifyListeners();
  }


  static CartItemsProvider of(BuildContext context, {bool listen = true}) {
    // Static method to retrieve the CartItemsProvider instance from the widget tree
    return Provider.of<CartItemsProvider>(
      context,
      listen: listen,
    );
  }
}
