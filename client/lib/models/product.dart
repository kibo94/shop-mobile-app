class Product {
  final int price;
  final String name;
  final id;
  final quantity;
  final String type;
  final String author;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.type,
      required this.author,
      required this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        author: json['author'],
        name: json['name'],
        price: json['price'],
        quantity: json['quantity]'],
        type: json['type']);
  }
}
