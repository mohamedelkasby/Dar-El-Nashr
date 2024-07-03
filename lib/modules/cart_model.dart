class CartModel {
  final String bookName;
  final String bookImg;
  final String bookCategory;
  final double bookPrice;
  bool bought;
  int count;
  double totalPrice;

  CartModel({
    required this.bookName,
    required this.bookImg,
    required this.bookCategory,
    required this.bookPrice,
    required this.totalPrice,
    this.count = 1,
    this.bought = false,
  });
}
