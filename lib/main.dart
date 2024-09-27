import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/helpers/page_animation.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/product_detail.dart';
import 'package:frontend/products_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ProductsScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == "product-detail") {
            return SlidePageRoute(
              builder: (_) =>
                  ProductDetail(settings.arguments as Map<String, Product>),
            );
          }

          return null;
        });
  }
}
