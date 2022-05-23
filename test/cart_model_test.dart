import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_fixed.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_n_for_n.dart';
import 'package:shopping_app/Core/Offers/offer_single.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';

void main() {
  Currency currency = Currency(name: "GBP", symbolMajor: "£", symbolMinor: "p");

  ItemModel item1 = ItemModel(itemId: 1, title: "Face Mask");
  ItemModel item2 = ItemModel(itemId: 2, title: "Toilet Roll");
  ItemModel item3 = ItemModel(itemId: 3, title: "Butter");

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

  test("Empty Cart", () {
    //Empty cart
    expect(cart.items.length, 0);
  });

  test("Add Items to Cart", () {
    //Adds first item
    cart.addItem(item1.itemId);
    expect(cart.items.length, 1);
    expect(cart.items[item1.itemId], 1);

    //Adds first item again, expects two units
    cart.addItem(item1.itemId);
    expect(cart.items[item1.itemId], 2);

    //Adds second item, expects two item types
    cart.addItem(item2.itemId);
    expect(cart.items.length, 2);
    expect(cart.items[item2.itemId], 1);
  });

  test("Remove Items from Cart", () {
    //Removes first item, expects one unit
    cart.removeItem(item1.itemId);
    expect(cart.items[item1.itemId], 1);

    //Removes first item, expects 0
    cart.removeItem(item1.itemId);
    expect(cart.items[item1.itemId], 0);

    //Removes first item when there isnt any, expects exception
    expect(() => cart.removeItem(item1.itemId), throwsA(isA<Exception>()));
  });

  test("Get Price for Item in Cart with Multiple Offers", () {
    //Adds second item
    cart.addItem(item3.itemId);
    expect(cart.getPriceForItem(itemId: item3.itemId).finalAmount, 180);

    cart.addItem(item3.itemId);
    expect(cart.getPriceForItem(itemId: item3.itemId).finalAmount, 360);

    cart.addItem(item3.itemId);
    expect(cart.getPriceForItem(itemId: item3.itemId).finalAmount, 390);

    cart.addItem(item3.itemId);
    expect(cart.getPriceForItem(itemId: item3.itemId).finalAmount, 570);
  });

  test("Clear Cart", () {
    cart.addItem(item2.itemId);

    cart.clearCart();
    expect(
        cart.items.values.fold(0, (int item1, int item2) => item1 + item2), 0);
  });

  test("Get Price for Item in Cart", () {
    //Adds second item
    cart.addItem(item2.itemId);
    expect(cart.getPriceForItem(itemId: item2.itemId).finalAmount, 65);

    cart.addItem(item2.itemId);
    expect(cart.getPriceForItem(itemId: item2.itemId).finalAmount, 130);

    cart.addItem(item2.itemId);
    expect(cart.getPriceForItem(itemId: item2.itemId).finalAmount, 195);

    cart.addItem(item2.itemId);
    expect(cart.getPriceForItem(itemId: item2.itemId).finalAmount, 195);

    cart.addItem(item2.itemId);
    expect(cart.getPriceForItem(itemId: item2.itemId).finalAmount, 260);
  });

  test("Get Total Price", () {
    //Adds first item
    cart.addItem(item1.itemId);
    expect(cart.getTotalPrice().finalAmount, 510);

    cart.addItem(item1.itemId);
    expect(cart.getTotalPrice().finalAmount, 660);
  });
}
