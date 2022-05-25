import 'package:flutter/cupertino.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Transitions/counter_transition.dart';

class ItemTilePrice extends StatelessWidget {
  const ItemTilePrice({
    Key? key,
    required this.currency,
    required this.price,
    this.longFormat = false,
    this.appendStringBeginning = "",
    this.appendStringEnd = "",
    this.onlyFade = false,
    this.style,
  }) : super(key: key);

  final Currency currency;
  final int price;
  final TextStyle? style;
  final String appendStringBeginning;
  final String appendStringEnd;
  final bool longFormat;
  final bool onlyFade;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) =>
          CounterTransition.transitionBuilder(child, animation, price,
              (child.key as ValueKey<int>).value, onlyFade),
      child: Text(
        key: ValueKey<int>(price),
        appendStringBeginning +
            currency.displayAmount(amount: price, longFormat: longFormat) +
            appendStringEnd,
        style: style,
      ),
    );
  }
}
