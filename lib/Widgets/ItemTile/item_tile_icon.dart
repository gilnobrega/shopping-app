import 'package:flutter/material.dart';
import 'package:shopping_app/Models/item_model.dart';

class ItemTileIcon extends StatelessWidget {
  const ItemTileIcon({Key? key, required this.item}) : super(key: key);

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: item.pictureUrl ?? "${item.itemId}Picture",
        child: item.pictureUrl == null
            ? const Icon(Icons.question_mark)
            : Image.network(item.pictureUrl!));
  }
}
