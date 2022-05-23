import 'package:flutter/material.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Widgets/shopping_cart_floating_button_label.dart';

class ShoppingCartFloatingButton extends StatelessWidget {
  static const buttonSize = 56.0;
  static const padding = 16.0;

  const ShoppingCartFloatingButton(
      {Key? key,
      this.onPressed,
      required this.totalPrice,
      required this.currency})
      : super(key: key);

  final VoidCallback? onPressed;
  final Price totalPrice;
  final Currency currency;

  static const Duration _animationDuration = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    bool cartIsEmpty = totalPrice.finalAmount == 0;

    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        //shows and hides label behind shopping cart button
        AnimatedSwitcher(
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            duration: _animationDuration,
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
                child: ShoppingCartFloatingButtonLabel(
                  buttonSize: buttonSize,
                  padding: padding,
                  currency: currency,
                  totalPrice: totalPrice,
                ))),
        Transform.translate(
            offset: const Offset(buttonSize / 2, 0),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: buttonSize,
              height: buttonSize,
            )),
        AnimatedRotation(
            duration: _animationDuration,
            curve: Curves.easeInOut,
            turns: cartIsEmpty ? 0 : -1,
            child: FloatingActionButton(
              onPressed: onPressed,
              tooltip: cartIsEmpty ? 'Cart is Empty' : 'View Cart',
              child: AnimatedSwitcher(
                  duration: _animationDuration,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity:
                          Tween<double>(begin: 0, end: 1).animate(animation),
                      child: child,
                    );
                  },
                  child: Icon(
                      key: ValueKey<bool>(cartIsEmpty),
                      cartIsEmpty
                          ? Icons.shopping_cart_outlined
                          : Icons.shopping_cart)),
            )),
      ],
    );
  }
}