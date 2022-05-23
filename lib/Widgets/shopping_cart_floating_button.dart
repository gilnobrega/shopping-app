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

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        //shows and hides label behind shopping cart button
        AnimatedSwitcher(
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            duration: const Duration(milliseconds: 150),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(1.0, 0),
                              end: const Offset(0.0, 0.0))
                          .animate(animation),
                      child: child,
                    ),
                    Transform.translate(
                        offset: const Offset(buttonSize / 2, 0),
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: buttonSize,
                          height: buttonSize,
                        )),
                  ]);
            },
            child: Opacity(
                opacity: totalPrice.finalAmount == 0 ? 0 : 1,
                key: ValueKey<bool>(totalPrice.finalAmount == 0),
                child: ShoppingCartFloatingButtonLabel(
                  buttonSize: buttonSize,
                  padding: padding,
                  currency: currency,
                  totalPrice: totalPrice,
                ))),
        FloatingActionButton(
          onPressed: onPressed,
          tooltip: 'View Cart',
          child: const Icon(Icons.shopping_cart),
        ),
      ],
    );
  }
}
