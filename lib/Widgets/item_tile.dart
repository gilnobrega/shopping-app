import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/item_tile_buttons.dart';
import 'package:shopping_app/Widgets/item_tile_main.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(
      {Key? key,
      required this.item,
      required this.price,
      required this.currency,
      required this.count,
      required this.addItem,
      required this.removeItem,
      this.offer})
      : super(key: key);

  final ItemModel item;
  final Offer? offer;
  final Price price;
  final Currency currency;
  final int count;
  final VoidCallback addItem;
  final VoidCallback removeItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        ItemTileMainBody(
          item: item,
          currency: currency,
          offer: offer,
          price: price,
        ),
        ItemTileButtons(addItem: addItem, removeItem: removeItem, count: count)
      ],
    );
  }
}
