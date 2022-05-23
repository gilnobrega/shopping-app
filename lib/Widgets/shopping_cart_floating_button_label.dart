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
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            //This placeholder enforces a minimum shopping label width
            //So the label doesnt resize between 9£ and 10£, etc.
            _generateText(context: context, text: "£00.00", placeHolder: true),
            AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: _generateText(
                    key: ValueKey<int>(totalPrice.finalAmount),
                    context: context,
                    text:
                        currency.displayAmount(amount: totalPrice.finalAmount)))
          ],
        ),
      )),
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
