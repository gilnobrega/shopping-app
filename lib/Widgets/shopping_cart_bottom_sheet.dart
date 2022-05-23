import 'package:flutter/material.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';

class ShoppingCartBottomBar extends StatelessWidget {
  const ShoppingCartBottomBar(
      {Key? key, required this.totalPrice, required this.currency})
      : super(key: key);

  final Price totalPrice;
  final Currency currency;

  static const _barHeight = 56.0;

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
            child: Text(
                'Total: ${currency.displayAmount(amount: totalPrice.finalAmount, longFormat: true)}',
                style: Theme.of(context).primaryTextTheme.headline6)));
  }
}
