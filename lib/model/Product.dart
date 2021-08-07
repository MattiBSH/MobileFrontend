
class Product {
  final String name;
  final String description;
  final double price;
  final int stock;
  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.stock
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
     
      price: json['price'] as double,   
      description: json['description'] as String,
      stock: json['stock'] as int,  
    );
  }
}