//E.g.: name: 'GBP', symbolMajor: '£', symbolMinor: 'p'

class Currency {
  final String name;
  final String symbolMajor;
  final String symbolMinor;

  Currency(
      {required this.name,
      required this.symbolMajor,
      required this.symbolMinor});

  String displayAmount({required int amount, bool longFormat = false}) {
    //If long format then returns e.g.: GBP 1.01
    if (longFormat) return ("$name ${(amount / 100.0).toStringAsFixed(2)}");

    //If amount is smaller than 1£ then returns e.g.: 65p
    if (amount < 100) return "$amount$symbolMinor";

    //If amount is 1£ or greater then returns e.g.: £1.21
    return "$symbolMajor${(amount / 100.0).toStringAsFixed(2)}";
  }
}
