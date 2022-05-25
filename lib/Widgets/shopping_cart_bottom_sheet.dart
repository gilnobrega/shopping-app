import 'package:flutter/material.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile_price.dart';

class ShoppingCartBottomBar extends StatelessWidget {
  const ShoppingCartBottomBar(
      {Key? key, required this.totalPrice, required this.currency})
      : super(key: key);

  final Price totalPrice;
  final Currency currency;

  static const _barHeight = 96.0;

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "TotalPriceLabel",
        child: Container(
            height: _barHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).buttonTheme.colorScheme!.background,
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16.0),
            child: Wrap(
              runSpacing: 0.25,
              children: [
                ItemTilePrice(
                    appendStringBeginning: "Sub Total: ",
                    longFormat: true,
                    price: totalPrice.originalAmount,
                    currency: currency,
                    onlyFade: true,
                    style: Theme.of(context).primaryTextTheme.bodyMedium),
                const SizedBox(
                  width: double.infinity,
                ),
                ItemTilePrice(
                    appendStringBeginning: "Total Discount: ",
                    longFormat: true,
                    price: totalPrice.discountedAmount,
                    currency: currency,
                    onlyFade: true,
                    style: Theme.of(context).primaryTextTheme.bodyMedium),
                const SizedBox(width: double.infinity, height: 4.0),
                Container(
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).buttonTheme.colorScheme!.background,
                    ),
                    child: ItemTilePrice(
                        appendStringBeginning: "Total: ",
                        longFormat: true,
                        price: totalPrice.finalAmount,
                        currency: currency,
                        style: Theme.of(context).primaryTextTheme.headline6)),
              ],
            )));
  }
}
