import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:complete_commerce_app/components/models/product.dart';
import 'package:complete_commerce_app/components/widgets/custom_textfield.dart';
import 'package:complete_commerce_app/features/admin/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('AdminHome'),
            bottom: TabBar(tabs: [
              Tab(
                text: 'New Product',
              ),
              Tab(
                text: 'All Products',
              )
            ]),
          ),
          body: TabBarView(children: [NewProduct(), AllProducts()]),
        ));
  }
}

enum textFieldType { name, desc, price }

class NewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        GestureDetector(onTap: () async {
          try {
            PickedFile pickedFile = await ImagePicker().getImage(
                source: ImageSource.camera, maxHeight: 150, maxWidth: 150);
            File file = File(pickedFile.path);
            Provider.of<AdminProvider>(context, listen: false)
                .uploadImage(file);
          } catch (error) {
            print(error);
          }
        }, child: Consumer<AdminProvider>(
          builder: (context, value, child) {
            String image = value.productImageUrl;
            if (image == null) {
              return Container(
                width: 150,
                height: 150,
                color: Colors.grey,
              );
            } else {
              return CachedNetworkImage(
                imageUrl: image,
                width: 150,
                height: 150,
              );
            }
          },
        )),
        CustomTextField(
          label: 'Name',
          type: textFieldType.name,
        ),
        CustomTextField(
          label: 'Description',
          type: textFieldType.desc,
        ),
        CustomTextField(
          label: 'Price',
          type: textFieldType.price,
        ),
        Spacer(),
        RaisedButton(onPressed: () {
          Provider.of<AdminProvider>(context, listen: false).addNewProduct();
        })
      ],
    );
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
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  Provider.of<AdminProvider>(context, listen: false)
                      .deleteProduct(allProducts[index].documentId);
                },
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(
                          allProducts[index].imageUrl),
                    ),
                  ),
                  title: Text(allProducts[index].name),
                ),
              );
            },
          );
        }
      },
    );
  }
}
