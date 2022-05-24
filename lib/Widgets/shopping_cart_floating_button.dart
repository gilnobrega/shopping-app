import 'package:flutter/material.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Widgets/shopping_cart_floating_button_label.dart';

class ShoppingCartFloatingButton extends StatelessWidget {
  static const buttonSize = 56.0;
  static const padding = 16.0;

  const ShoppingCartFloatingButton(
      {Key? key,
      required this.onShoppingCartFloatingButtonPressed,
      required this.totalPrice,
      required this.currency,
      required this.cartIsEmpty})
      : super(key: key);

  final VoidCallback? onShoppingCartFloatingButtonPressed;
  final Price totalPrice;
  final bool cartIsEmpty;
  final Currency currency;

  static const Duration _animationDuration = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        //shows and hides label behind shopping cart button
        ShoppingCartFloatingButtonLabel(
          animationDuration: _animationDuration,
          cartIsEmpty: cartIsEmpty,
          buttonSize: buttonSize,
          padding: padding,
          currency: currency,
          totalPrice: totalPrice,
        ),
        Transform.translate(
            offset: const Offset(buttonSize / 2, 0),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: buttonSize,
              height: buttonSize,
            )),
        Hero(
            tag: "ShoppingCartFloatingButtonHeroTag",
            child: AnimatedRotation(
                duration: _animationDuration,
                curve: Curves.easeInOut,
                turns: cartIsEmpty ? 0 : -1,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: (cartIsEmpty)
                      ? null
                      : onShoppingCartFloatingButtonPressed,
                  tooltip: cartIsEmpty ? 'Cart is Empty' : 'View Cart',
                  child: AnimatedSwitcher(
                      duration: _animationDuration,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: Tween<double>(begin: 0, end: 1)
                              .animate(animation),
                          child: child,
                        );
                      },
                      child: Icon(
                          key: ValueKey<bool>(cartIsEmpty),
                          cartIsEmpty
                              ? Icons.shopping_cart_outlined
                              : Icons.shopping_cart)),
                ))),
      ],
    );
  }
}
