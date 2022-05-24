import 'package:flutter/material.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile_icon.dart';

class ItemDetailsLandscape extends StatelessWidget {
  const ItemDetailsLandscape({Key? key, required this.item}) : super(key: key);

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: const EdgeInsets.all(16),
            child: Stack(children: [
              Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  padding: const EdgeInsets.only(left: 100, top: 64),
                  child: Card(
                      elevation: 8,
                      child: Container(
                          padding: const EdgeInsets.only(left: 200),
                          child: SingleChildScrollView(
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      right: 64, top: 16, left: 16, bottom: 32),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3),
                                      const SizedBox(height: 16),
                                      Text(item.description ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                    ],
                                  )))))),
              Positioned(
                  left: 0,
                  top: 0,
                  child: Card(
                      elevation: 8,
                      child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                              width: 256,
                              height: 256,
                              child: ItemTileIcon(
                                item: item,
                              )))))
            ])));
  }
}
