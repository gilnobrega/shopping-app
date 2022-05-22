import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/Core/currency.dart';

void main() {
  Currency currency = Currency(name: "GBP", symbolMajor: "£", symbolMinor: "p");

  test('Display value greater or equal to 1£', () {
    expect(currency.displayAmount(amount: 123), "£1.23");
    expect(currency.displayAmount(amount: 120), "£1.20");
    expect(currency.displayAmount(amount: 100), "£1.00");
  });

  test('Display value less than 1£', () {
    expect(currency.displayAmount(amount: 65), "65p");
    expect(currency.displayAmount(amount: 4), "4p");
  });

  test('Display long format', () {
    expect(currency.displayAmount(amount: 65, longFormat: true), "GBP 0.65");
    expect(currency.displayAmount(amount: 120, longFormat: true), "GBP 1.20");
  });
}
