import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/Core/price.dart';

void main() {
  test("Initialize Price", () {
    Price price = Price(originalAmount: 100, finalAmount: 60);

    expect(price.originalAmount, 100);
    expect(price.finalAmount, 60);
    expect(price.discountedAmount, 40);
  });

  test("Combine Prices", () {
    Price price1 = Price(originalAmount: 150, finalAmount: 140);
    Price price2 = Price(originalAmount: 60, finalAmount: 30);

    Price combinedPrice = price1 + price2;

    expect(combinedPrice.originalAmount, 210);
    expect(combinedPrice.finalAmount, 170);
    expect(combinedPrice.discountedAmount, 40);
  });

  test("Expect Exception on Invalid Prices", () {
    expect(() => Price(originalAmount: -10, finalAmount: 10),
        throwsA(isA<Exception>()));

    expect(() => Price(originalAmount: 10, finalAmount: -10),
        throwsA(isA<Exception>()));

    expect(() => Price(originalAmount: 10, finalAmount: 100),
        throwsA(isA<Exception>()));
  });
}
