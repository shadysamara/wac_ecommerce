import 'package:cached_network_image/cached_network_image.dart';
import 'package:complete_commerce_app/components/models/Order.dart';
import 'package:complete_commerce_app/components/models/product.dart';
import 'package:complete_commerce_app/features/admin/providers/admin_provider.dart';
import 'package:complete_commerce_app/features/admin/providers/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('CLIENT HOME'),
            bottom: TabBar(tabs: [
              Tab(
                text: 'All Products',
              ),
              Tab(
                text: 'Cart',
              ),
            ]),
          ),
          body: TabBarView(children: [AllProducts(), Container()]),
        ));
  }
}

class AllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<AdminProvider>(context, listen: false).getAllProducts();
    // TODO: implement build
    return Consumer<AdminProvider>(
      builder: (context, value, child) {
        List<Product> allProducts = value.allProducts;
        print(allProducts.length);
        if (allProducts.isEmpty) {
          return Center(
            child: Text('No Products'),
          );
        } else {
          return ListView.builder(
            itemCount: allProducts.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Provider.of<ClientProvider>(context, listen: false)
                          .addNewOrder(Order(
                              documentId: allProducts[index].documentId,
                              userId: 'shady'));
                    }),
                leading: Container(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        CachedNetworkImageProvider(allProducts[index].imageUrl),
                  ),
                ),
                title: Text(allProducts[index].name),
              );
            },
          );
        }
      },
    );
  }
}
