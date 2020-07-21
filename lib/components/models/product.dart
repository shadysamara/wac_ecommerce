import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String documentId;
  String name;
  String description;
  int price;
  String imageUrl;
  Product(
      {this.description,
      this.documentId,
      this.imageUrl,
      this.name,
      this.price});
  Product.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.documentId = documentSnapshot.documentID;
    this.name = documentSnapshot.data['name'];
    this.description = documentSnapshot.data['description'];
    this.imageUrl = documentSnapshot.data['imageUrl'];
    this.price = documentSnapshot.data['price'];
  }
  toJson() {
    return {
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'imageUrl': this.imageUrl
    };
  }
}
