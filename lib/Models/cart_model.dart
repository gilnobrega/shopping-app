import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/currency.dart';

class CartModel {
  final List<Offer> availableOffers;

  //dictionary with item id and number of item id that are added to cart
  final Map<int, int> items = {};

  final Currency currency;

  //increments number of items with this itemid
  void addItem(int itemId) {
    items[itemId] = (items[itemId] ?? 0) + 1;
  }

  //decreases counter of number of items with this itemid
  //returns false if item could not be removed
  void removeItem(int itemId) {
    if ((items[itemId] ?? 0) == 0) {
      throw Exception("Cannot remove item as it is not in the cart");
    }

    items[itemId] = items[itemId]! - 1;
  }

  CartModel({required this.currency, required this.availableOffers});
}
