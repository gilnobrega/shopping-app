import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/currency.dart';

class CartModel {
  final List<Offer> availableOffers;

  //dictionary with item id and number of item id that are added to cart
  final Map<int, int> _items = {};

  final Currency currency;

  //increments number of items with this itemid
  void addItem(int itemId) {
    _items[itemId] = (_items[itemId] ?? 0) + 1;
  }

  //decreases counter of number of items with this itemid
  //returns false if item could not be removed
  bool removeItem(int itemId) {
    if ((_items[itemId] ?? 0) == 0) return false;

    _items[itemId] = _items[itemId]! - 1;
    return true;
  }

  CartModel({required this.currency, required this.availableOffers});
}
