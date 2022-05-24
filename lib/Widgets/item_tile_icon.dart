import 'package:flutter/cupertino.dart';
import 'package:shopping_app/Models/item_model.dart';

class ItemTileIcon extends StatelessWidget {
  const ItemTileIcon({Key? key, required this.item}) : super(key: key);

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: item.pictureUrl ?? "${item.itemId}Picture",
        child: Image.network(item.pictureUrl ?? ""));
  }
}
