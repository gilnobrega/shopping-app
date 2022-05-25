import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_fixed.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_n_for_n.dart';
import 'package:shopping_app/Core/Offers/offer_single.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/constants.dart';

import 'package:shopping_app/main.dart';

void main() {
  Currency currency = Currency(name: "GBP", symbolMajor: "£", symbolMinor: "p");

  ItemModel item1 = ItemModel(
      itemId: 1, title: "Face Mask", description: Constants.loremIpsum);
  ItemModel item2 = ItemModel(
      itemId: 2, title: "Toilet Roll", description: Constants.loremIpsum);
  ItemModel item3 =
      ItemModel(itemId: 3, title: "Butter", description: Constants.loremIpsum);

  Offer offer1 = OfferMultibuyFixed(
      offerUnits: 2, offerAmount: 400, itemId: 1, originalUnitPrice: 250);
  Offer offer2 = OfferMultibuyNForN(
      offerUnits: 4, forUnits: 3, itemId: 2, originalUnitPrice: 65);

  Offer offer3 = OfferMultibuyNForN(
      offerUnits: 3, forUnits: 2, itemId: 3, originalUnitPrice: 195);
  Offer offer4 =
      OfferSingle(discountedAmount: 15, itemId: 3, originalUnitPrice: 195);

  CartModel cart = CartModel(
      currency: currency,
      availableOffers: [offer1, offer2, offer3, offer4],
      availableItems: [item1, item2, item3]);

  testWidgets('Adds and Removes items', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ShoppingApp(
      cart: cart,
    ));

    // Verifies a title exists for each object
    expect(find.text('Face Mask'), findsOneWidget);
    expect(find.text('Toilet Roll'), findsOneWidget);
    expect(find.text('Butter'), findsOneWidget);

    //Empty Shopping cart button
    expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart), findsNothing);

    //One add button per tile
    expect(find.widgetWithText(TextButton, "Add"), findsNWidgets(3));

    // Adds first item to cart
    await tester.tap(find.widgetWithText(TextButton, "Add").first);
    await tester.pumpAndSettle();

    //Filled Shopping cart button
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart_outlined), findsNothing);

    // Verify that our counter has incremented. It should be 1
    expect(find.text('2'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
    expect(find.widgetWithText(TextButton, "Add"), findsNWidgets(2));
    //Total label should be £2.50
    expect(find.text('£2.50'), findsNWidgets(2));
    expect(find.text('£4.00'), findsNothing);
    expect(find.text('£5.00'), findsNothing);

    // Tap the '+' icon to add item
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that our counter has incremented. It should be 2
    expect(find.text('2'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    expect(find.text('0'), findsNothing);
    //Total label should be £4.00 with offer
    expect(find.text('£2.50'), findsOneWidget); //original retail price
    expect(find.text('£4.00'), findsOneWidget); //total shopping cart price
    expect(find.text('£5.00'), findsNothing);

    // Tap the '-' icon to remove item
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();

    // Verify that our counter has decreased. Should be 1
    expect(find.text('2'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
    //Total label should be £2.50 again
    expect(find.text('£2.50'), findsNWidgets(2));
    expect(find.text('£4.00'), findsNothing);
    expect(find.text('£5.00'), findsNothing);

    // Tap the '-' icon to remove item. Should be 0
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();

    // Verify that our counter has decreased.
    expect(find.text('2'), findsNothing);
    expect(find.text('1'), findsNothing);
    expect(find.text('0'), findsNothing);
    //Add number shows again
    expect(find.widgetWithText(TextButton, "Add"), findsNWidgets(3));
  });

  testWidgets('Navigate to checkout page - empty cart',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ShoppingApp(
      cart: cart,
    ));

    //Empty Shopping cart button
    expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart), findsNothing);

    //Open empty checkout page
    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.pumpAndSettle();

    //card payment icon
    expect(find.byIcon(Icons.payment), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart_outlined), findsNothing);
    expect(find.byIcon(Icons.shopping_cart), findsNothing);
    expect(find.text('Total: GBP 0.00'), findsOneWidget);
    expect(find.text('Total Discount: GBP 0.00'), findsOneWidget);
    expect(find.text('Sub Total: GBP 0.00'), findsOneWidget);
    expect(find.text('Your cart is empty 🙁'), findsOneWidget);
  });

  testWidgets('Navigate to checkout page - with 2 face masks',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ShoppingApp(
      cart: cart,
    ));

    // Adds first item to cart twice
    await tester.tap(find.widgetWithText(TextButton, "Add").first);
    await tester.tap(find.widgetWithText(TextButton, "Add").first);
    await tester.pumpAndSettle();

    //Empty Shopping cart button
    expect(find.byIcon(Icons.payment), findsNothing);
    expect(find.byIcon(Icons.shopping_cart_outlined), findsNothing);
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);

    //Open empty checkout page
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();

    //card payment icon
    expect(find.byIcon(Icons.payment), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart_outlined), findsNothing);
    expect(find.byIcon(Icons.shopping_cart), findsNothing);
    expect(find.text('Total: GBP 4.00'), findsOneWidget);
    expect(find.text('Total Discount: GBP 1.00'), findsOneWidget);
    expect(find.text('Sub Total: GBP 5.00'), findsOneWidget);
    expect(find.text('Face Mask'), findsOneWidget);
  });

  testWidgets('Open item details', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ShoppingApp(
      cart: cart,
    ));

    //Expects one tile with butter
    expect(find.text("Butter"), findsOneWidget);
    expect(find.textContaining("Lorem ipsum"), findsNothing);

    // Opens butter details
    await tester.tap(find.text("Butter"));
    await tester.pumpAndSettle();

    //expects app bar title to be butter and lorem ipsum description
    expect(find.text("Butter"), findsNWidgets(2));
    expect(find.textContaining("Lorem ipsum dolor "), findsOneWidget);
  });
}
