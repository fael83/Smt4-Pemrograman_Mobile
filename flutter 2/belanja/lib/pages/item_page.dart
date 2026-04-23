import 'package:belanja/models/item.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemPage extends StatelessWidget {
  final Item item;

   ItemPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: item.name,
            child: Image.asset(item.image),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Harga: Rp ${item.price}"),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Stok: ${item.stock}"),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Rating: ${item.rating} ⭐"),
          ),
        ],
      ),
    );
  }
}