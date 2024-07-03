import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.category,
  });

  // Factory method to create a Product from a Firestore document
  factory Product.fromFirestore(Map<String, dynamic> data) {

    return Product(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      price: data['price'],
      imageUrl: data['imageUrl'],
      category: data['category'],
      quantity: data['quantity'],
    );
  }

  // Method to convert a Product to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'quantity': quantity,
    };
  }
}
