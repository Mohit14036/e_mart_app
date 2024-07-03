import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/models/product.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');

  // Add to favorites
  Future<void> addToFavorites(Product product) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await userCollection.doc(user.uid).update({
        'favorites': FieldValue.arrayUnion([product.toFirestore()])
      });
    }
  }
  // Remove from favorites
  Future<void> removeFromFavorites(Product product) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await userCollection.doc(user.uid).update({
        'favorites': FieldValue.arrayRemove([product.toFirestore()])
      });
    }
  }

  // Add to cart
  Future<void> addToCart(List<Product> products) async {
    User? user = _auth.currentUser;
    if (user != null) {
      List<Map<String, dynamic>> productsToAdd =
      products.map((product) => product.toFirestore()).toList();
      await userCollection.doc(user.uid).update({
        'cart': FieldValue.arrayUnion(productsToAdd)
      });
    }
  }

  // Remove from cart
  Future<void> removeFromCart(Product product) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await userCollection.doc(user.uid).update({
        'cart': FieldValue.arrayRemove([product.toFirestore()])
      });
    }
  }

  // Checkout (add cart contents to orders)
  Future<void> checkout(List<Product> products) async {
    User? user = _auth.currentUser;
    if (user != null) {
      final ordersCollection = userCollection.doc(user.uid).collection('orders');
      for (Product product in products) {
        await ordersCollection.add(product.toFirestore());
      }
      await userCollection.doc(user.uid).update({
        'products': FieldValue.delete()
      });
    } else {
      throw FirebaseAuthException(code: 'USER_NOT_AUTHENTICATED', message: 'User not authenticated');
    }
  }


  // Fetch user favorites
  Future<List<Product>> fetchFavorites() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await userCollection.doc(user.uid).get();
      List<dynamic> favorites = doc['favorites'];
      return favorites.map((item) => Product.fromFirestore(item as Map<String, dynamic>)).toList();
    }
    return [];
  }

  // Fetch user cart
  Future<List<Product>> fetchCart() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await userCollection.doc(user.uid).get();
      List<dynamic> cart = doc['cart'];
      return cart.map((item) => Product.fromFirestore(item as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<bool> isFavorite(String productId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await userCollection.doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        List<dynamic> favorites = doc['favorites'] ?? [];
        return favorites.any((element) => (element as Map<String, dynamic>)['title'] == productId);
      }
    }
    return false;
  }
}





