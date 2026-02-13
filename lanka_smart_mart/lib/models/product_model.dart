class ProductModel {
  final String id;
  final String name;
  final String unitText;
  final int price;
  final String imagePath;
  final bool isOrganic;
  final bool inStock;
  final bool highFiber;
  final String? description;
  final String? category; // For categorizing products (Fruits, Vegetables, etc.)

  ProductModel({
    required this.id,
    required this.name,
    required this.unitText,
    required this.price,
    required this.imagePath,
    this.isOrganic = false,
    this.inStock = true,
    this.highFiber = false,
    this.description,
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

  int get totalPrice => product.price * quantity;
}
