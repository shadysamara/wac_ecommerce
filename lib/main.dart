import 'package:complete_commerce_app/features/admin/providers/admin_provider.dart';
import 'package:complete_commerce_app/features/admin/providers/client_provider.dart';
import 'package:complete_commerce_app/features/admin/ui/admin_home.dart';
import 'package:complete_commerce_app/features/admin/ui/customer_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdminProvider>(
          create: (BuildContext context) {
            return AdminProvider();
          },
        ),
        ChangeNotifierProvider<ClientProvider>(
          create: (BuildContext context) {
            return ClientProvider();
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: CustomerHome(),
      ),
    );
  }
}
