import 'package:flutter/material.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';

class ShoppingCartFloatingButtonLabel extends StatelessWidget {
  const ShoppingCartFloatingButtonLabel(
      {Key? key,
      required this.buttonSize,
      required this.padding,
      required this.totalPrice,
      required this.currency})
      : super(key: key);

  final double buttonSize;
  final double padding;
  final Price totalPrice;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: padding, right: buttonSize / 2 + padding),
      margin: EdgeInsets.symmetric(horizontal: buttonSize / 2),
      height: 56.0,
      decoration: BoxDecoration(
          color: Theme.of(context).buttonTheme.colorScheme!.background,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(buttonSize / 2),
              bottomLeft: Radius.circular(buttonSize / 2))),
      child: IntrinsicWidth(
          child: Center(
              child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Text(
            key: ValueKey<int>(totalPrice.finalAmount),
            currency.displayAmount(amount: totalPrice.finalAmount),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white)),
      ))),
    );
  }
}
