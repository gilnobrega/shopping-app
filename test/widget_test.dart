import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_fixed.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_n_for_n.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';

import 'package:shopping_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    Currency currency =
        Currency(name: "GBP", symbolMajor: "£", symbolMinor: "p");

    ItemModel item1 = ItemModel(itemId: 1, title: "Face Mask");
    ItemModel item2 = ItemModel(itemId: 2, title: "Toilet Roll");

    Offer offer1 = OfferMultibuyFixed(
        offerUnits: 2, offerAmount: 400, itemId: 1, originalUnitPrice: 250);
    Offer offer2 = OfferMultibuyNForN(
        offerUnits: 4, forUnits: 3, itemId: 2, originalUnitPrice: 65);

    CartModel cart = CartModel(
        currency: currency,
        availableOffers: [offer1, offer2],
        availableItems: [item1, item2]);

    // Build our app and trigger a frame.
    await tester.pumpWidget(ShoppingApp(
      cart: cart,
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
