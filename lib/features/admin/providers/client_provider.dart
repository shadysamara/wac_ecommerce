import 'package:complete_commerce_app/components/models/Order.dart';
import 'package:complete_commerce_app/components/models/product.dart';
import 'package:complete_commerce_app/features/admin/respository/admin_client.dart';
import 'package:flutter/material.dart';

class ClientProvider extends ChangeNotifier {
  addNewOrder(Order order) async {
    AdminClient.adminClient.insertNewProductToCart(order);
  }
}
