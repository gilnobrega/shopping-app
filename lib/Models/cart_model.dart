import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Models/item_model.dart';

class CartModel {
  final List<Offer> availableOffers;
  final List<ItemModel> availableItems;

  //dictionary with item id and number of item id that are added to cart
  final Map<int, int> items = {};

  final Currency currency;

  CartModel(
      {required this.currency,
      required this.availableOffers,
      required this.availableItems});

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

  //Gets available offers for a specific item
  Iterable<Offer> getOffersForItem({required int itemId}) {
    return availableOffers.where((offer) => itemId == offer.itemId);
  }

  Price getPriceForItem({required int itemId, int? itemCount}) {
    //gets item count from list of items if item count is not specified
    itemCount = itemCount ?? items[itemId] ?? 0;

    //Calculates prices for all available offers that match this item id
    return getOffersForItem(itemId: itemId)
        .map((e) => e.getPrice(itemCount: itemCount))
        //returns price with lowest final amount
        .reduce((price1, price2) =>
            price1.finalAmount < price2.finalAmount ? price1 : price2);
  }

  Price getTotalPrice() {
    Price initialPrice = Price(originalAmount: 0, finalAmount: 0);
    return items.entries
        .map((e) => getPriceForItem(itemId: e.key))
        .fold(initialPrice, (price1, price2) => price1 + price2);
  }

  void clearCart() {
    items.forEach((key, value) {
      items[key] = 0;
    });
  }
}
