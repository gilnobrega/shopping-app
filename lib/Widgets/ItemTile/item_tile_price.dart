import 'package:flutter/cupertino.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Transitions/counter_transition.dart';

class ItemTilePrice extends StatelessWidget {
  const ItemTilePrice({
    Key? key,
    required this.currency,
    required this.totalPrice,
    this.pricePerUnit = 0,
    this.longFormat = false,
    this.appendString = "",
    this.onlyFade = false,
    this.style,
  }) : super(key: key);

  final Currency currency;
  final int totalPrice;
  final int pricePerUnit;
  final TextStyle? style;
  final String appendString;
  final bool longFormat;
  final bool onlyFade;

  @override
  Widget build(BuildContext context) {
    var price = totalPrice == 0 ? pricePerUnit : totalPrice;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) =>
          CounterTransition.transitionBuilder(child, animation, price,
              (child.key as ValueKey<int>).value, onlyFade),
      child: Text(
        key: ValueKey<int>(price),
        appendString +
            currency.displayAmount(amount: price, longFormat: longFormat),
        style: style,
      ),
    );
  }
}
