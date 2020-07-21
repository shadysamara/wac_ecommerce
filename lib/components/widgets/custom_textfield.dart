import 'package:complete_commerce_app/features/admin/providers/admin_provider.dart';
import 'package:complete_commerce_app/features/admin/ui/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  String label;
  textFieldType type;
  CustomTextField({this.label, this.type});
  @override
  Widget build(BuildContext context) {
    AdminProvider provider = Provider.of<AdminProvider>(context, listen: false);
    // TODO: implement build
    return TextField(
      onChanged: (value) {
        if (type == textFieldType.name) {
          provider.setProductName(value);
        } else if (type == textFieldType.desc) {
          provider.setProductDescription(value);
        } else if (type == textFieldType.price) {
          provider.setProductPrice(value);
        }
      },
      keyboardType: type == textFieldType.price
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
          labelText: this.label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
