import 'package:flutter/cupertino.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Transitions/counter_transition.dart';

class ItemTilePrice extends StatelessWidget {
  const ItemTilePrice({
    Key? key,
    required this.currency,
    required this.totalPrice,
    required this.pricePerUnit,
    this.appendString = "",
    this.style,
  }) : super(key: key);

  final Currency currency;
  final int totalPrice;
  final int pricePerUnit;
  final TextStyle? style;
  final String appendString;

  @override
  Widget build(BuildContext context) {
    var price = totalPrice == 0 ? pricePerUnit : totalPrice;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      transitionBuilder: (child, animation) =>
          CounterTransition.transitionBuilder(
              child, animation, price, (child.key as ValueKey<int>).value),
      child: Text(
        key: ValueKey<int>(price),
        appendString + currency.displayAmount(amount: price),
        style: style,
      ),
    );
  }
}
