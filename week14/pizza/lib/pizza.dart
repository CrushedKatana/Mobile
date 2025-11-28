import 'dart:convert';

class Pizza {
  final String pizzaName;
  final String description;
  final double price;

  Pizza({required this.pizzaName, required this.description, required this.price});

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      pizzaName: json['pizzaName'] ?? json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] is String)
              ? double.tryParse(json['price']) ?? 0.0
              : (json['price'] as double? ?? 0.0),
    );
  }

  Map<String, dynamic> toJson() => {
        'pizzaName': pizzaName,
        'description': description,
        'price': price,
      };

  @override
  String toString() => jsonEncode(toJson());
}
