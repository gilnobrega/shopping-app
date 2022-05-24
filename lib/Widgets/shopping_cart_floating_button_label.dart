import 'package:flutter/material.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';

class ShoppingCartFloatingButtonLabel extends StatelessWidget {
  const ShoppingCartFloatingButtonLabel(
      {Key? key,
      required this.buttonSize,
      required this.padding,
      required this.totalPrice,
      required this.currency,
      required this.cartIsEmpty,
      required this.animationDuration})
      : super(key: key);

  final double buttonSize;
  final double padding;
  final Price totalPrice;
  final Currency currency;
  final bool cartIsEmpty;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius =
        BorderRadius.all(Radius.circular(buttonSize / 2));
    return Hero(
      tag: "TotalPriceLabel",
      child: ClipRRect(
          borderRadius: borderRadius,
          child: AnimatedSwitcher(
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              duration: animationDuration,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(1.0, 0),
                            end: const Offset(0.0, 0.0))
                        .animate(animation),
                    child: child);
              },
              child: Opacity(
                  opacity: cartIsEmpty ? 0 : 1,
                  key: ValueKey<bool>(cartIsEmpty),
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: EdgeInsets.only(
                          left: padding, right: buttonSize + padding),
                      height: 56.0,
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .background,
                          borderRadius: borderRadius),
                      child: IntrinsicWidth(
                        child: Center(
                            child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                transitionBuilder: (child, animation) {
                                  return ScaleTransition(
                                      scale: animation, child: child);
                                },
                                child: _generateText(
                                    key: ValueKey<int>(totalPrice.finalAmount),
                                    context: context,
                                    text: currency.displayAmount(
                                        amount: totalPrice.finalAmount)))),
                      ))))),
    );
  }

  Widget _generateText(
      {required BuildContext context,
      required String text,
      Key? key,
      bool placeHolder = false}) {
    return Text(
        key: key,
        text,
        style: Theme.of(context).textTheme.headline6!.copyWith(
            color: Theme.of(context)
                .primaryIconTheme
                .color!
                .withAlpha(placeHolder ? 0 : 255)));
  }
}
