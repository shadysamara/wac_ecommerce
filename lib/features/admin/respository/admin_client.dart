import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_commerce_app/components/models/Order.dart';
import 'package:complete_commerce_app/components/models/product.dart';
import 'package:complete_commerce_app/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminClient {
  /// check the user type
  AdminClient._();
  static AdminClient adminClient = AdminClient._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Firestore firestore = Firestore.instance;
  Future<String> uploadImage(File file) async {
    try {
      DateTime dateTime = DateTime.now();
      StorageTaskSnapshot snapshot = await firebaseStorage
          .ref()
          .child('$imagesFolder/$dateTime.jpg')
          .putFile(file)
          .onComplete;
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (error) {
      print(error);
    }
  }

  // deleteImage(String imageUrl) async {
  //   try {
  //     await firebaseStorage.ref().child('$imagesFolder/$imageUrl').delete();
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  Future<String> uploadProduct(Product product) async {
    try {
      DocumentReference documentReference =
          await firestore.collection(productsCollection).add(product.toJson());
      assert(documentReference.documentID != null);
      return documentReference.documentID;
    } catch (error) {
      print(error);
    }
  }

  Future<List<DocumentSnapshot>> getAllProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection(productsCollection).getDocuments();
      return querySnapshot.documents;
    } catch (error) {
      print(error);
    }
  }

  insertNewProductToCart(Order order) async {
    firestore.collection('Cart').add(order.toJson());
  }

  updateProduct(Product product) async {
    try {
      firestore
          .collection(productsCollection)
          .document(product.documentId)
          .setData(product.toJson());
    } catch (error) {
      print(error);
    }
  }

  deleteProduct(String productId) async {
    try {
      firestore.collection(productsCollection).document(productId).delete();
    } catch (error) {
      print(error);
    }
  }
}
