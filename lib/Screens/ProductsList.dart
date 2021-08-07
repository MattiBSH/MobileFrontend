import 'package:flutter/material.dart';
import 'package:backendhandling/model/Product.dart';
class ProductsList extends StatelessWidget {
  const ProductsList({Key? key, required this.products}) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  color:Colors.blue,
                    child: Column(
                      children: [
                        Text(products[index].name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)
                                ),
                                Text(products[index].description,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)
                                ),
                                Text(products[index].price.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)
                                ),
                      ],
                    ),
                            
                  ),
                          
                
                
              ],
            ));
      },
    );
  }
  }