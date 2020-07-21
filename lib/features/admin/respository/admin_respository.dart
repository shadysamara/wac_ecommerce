import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_commerce_app/components/models/product.dart';
import 'package:complete_commerce_app/features/admin/respository/admin_client.dart';

class AdminRepository {
  AdminRepository._();
  static AdminRepository adminRepository = AdminRepository._();
  // addNewProduct(Product product, File imageFile) async {
  //   try {
  //     String url = await AdminClient.adminClient.uploadImage(imageFile);
  //     product.imageUrl = url;
  //     String id = await AdminClient.adminClient.uploadProduct(product);
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  Future<List<Product>> getAllProducts() async {
    List<DocumentSnapshot> documents =
        await AdminClient.adminClient.getAllProducts();
    List<Product> products =
        documents.map((e) => Product.fromDocumentSnapshot(e)).toList();
    return products;
  }
}
