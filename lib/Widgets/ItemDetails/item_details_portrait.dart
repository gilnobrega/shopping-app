import 'package:flutter/material.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile_icon.dart';

class ItemDetailsPortrait extends StatelessWidget {
  const ItemDetailsPortrait({Key? key, required this.item}) : super(key: key);

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Card(
              elevation: 8,
              child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: ItemTileIcon(
                    item: item,
                  ))),
        ),
        if (item.description != null)
          Card(
            elevation: 8,
            child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(item.description!)),
          )
      ],
    );
  }
}
