class Item {
  String name;
  int price;
  String image;
  int stock;
  double rating;

  Item({required this.name, required this.price, this.image = '', this.stock = 0, this.rating = 0.0});
}