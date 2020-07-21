import 'dart:io';

import 'package:complete_commerce_app/components/models/product.dart';
import 'package:complete_commerce_app/features/admin/respository/admin_client.dart';
import 'package:complete_commerce_app/features/admin/respository/admin_respository.dart';
import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier {
  List<Product> allProducts = [];
  String productName;
  String productDescription;
  int productPrice;
  String productImageUrl;
  setProductName(String name) {
    this.productName = name;
    notifyListeners();
  }

  setProductDescription(String name) {
    this.productDescription = name;
    notifyListeners();
  }

  setProductPrice(String name) {
    try {
      this.productPrice = int.parse(name);
    } catch (error) {
      print(error);
    }
  }

  uploadImage(File file) async {
    String url = await AdminClient.adminClient.uploadImage(file);
    this.productImageUrl = url;
    notifyListeners();
  }

  addNewProduct() async {
    try {
      Product product = Product(
        imageUrl: this.productImageUrl,
        description: this.productDescription,
        name: this.productName,
        price: this.productPrice,
      );
      String productId = await AdminClient.adminClient.uploadProduct(product);
      assert(productId != null);
      print(productId);
      getAllProducts();
    } catch (error) {
      print(error);
    }
  }

  getAllProducts() async {
    allProducts = await AdminRepository.adminRepository.getAllProducts();
    notifyListeners();
  }

  updateProduct(Product product) async {
    await AdminClient.adminClient.updateProduct(product);
    getAllProducts();
  }

  deleteProduct(String documentId) async {
    await AdminClient.adminClient.deleteProduct(documentId);
    getAllProducts();
  }
}
