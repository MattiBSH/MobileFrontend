import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "../model/Product.dart";
import 'dart:async';
import 'dart:convert';
import 'ProductsList.dart';
//import 'AddProduct.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;


Future<List<Product>> fetchProducts(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://localhost:8080/jpareststarter/api/products/all'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseProduct, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Product> parseProduct(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return ProductsList(products: snapshot.data!);
               // MyProductAdd()
              
    
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}