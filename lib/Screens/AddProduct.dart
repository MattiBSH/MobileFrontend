
import "package:flutter/material.dart";
import '../model/Product.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'dart:core';

class MyProductAdd extends StatefulWidget {
  const MyProductAdd({Key? key}) : super(key: key);

  @override
  _AddProduct createState() {
    return _AddProduct();
  }
}
class _AddProduct extends State<MyProductAdd> {
  final TextEditingController _name = TextEditingController();
    final TextEditingController _description = TextEditingController();

  final TextEditingController _price = TextEditingController();
 final TextEditingController _stock = TextEditingController();
  Future<Product>? _futureAlbum;

Future<Product> createProduct(String name,String description, double price ,int stock) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/jpareststarter/api/products/add'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
       'Accept': "application/json",
    },
    body: jsonEncode(<String, Object>{
      'name': name,
      'price': 22.22,
      'description': description,
      'stock':2
    }),
    
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Product.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create Product.');
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }
    Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _name,
          decoration: const InputDecoration(hintText: 'Enter Name'),
        ),
        TextField(
          controller: _description,
          decoration: const InputDecoration(hintText: 'Enter Description'),
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'Enter Price'),
           controller: _price,
          
        ),
        TextField(
           decoration: const InputDecoration(hintText: 'Enter Stock'),
           controller: _stock,
          
        ),
    
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createProduct(_name.text,_description.text,double.parse(_price.text),int.parse(_stock.text));
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Product> buildFutureBuilder() {
    return FutureBuilder<Product>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}