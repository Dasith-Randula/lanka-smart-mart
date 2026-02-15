class ProductModel {
  final String id;
  final String name;
  final String unitText;
  final double price;
  final String description;
  final String? imagePath;
  final String? category;

  ProductModel({
    required this.id,
    required this.name,
    required this.unitText,
    required this.price,
    required this.description,
    this.imagePath,
    this.category,
  });
}

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.product,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;
}
