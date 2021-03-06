import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy.dart';
import 'package:shopping_app/Core/Offers/offer_none.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Models/item_model.dart';

class CartModel {
  late final List<Offer> availableOffers;
  final List<ItemModel> availableItems;

  List<ItemModel> get itemsInCart => availableItems
      .where(
          (item) => items.containsKey(item.itemId) && items[item.itemId]! > 0)
      .toList();

  //dictionary with item id and number of item id that are added to cart
  final Map<int, int> items = {};

  bool get isEmpty =>
      items.values.fold(0, (int item1, int item2) => item1 + item2) == 0;

  final Currency currency;

  CartModel(
      {required this.currency,
      required availableOffers,
      required this.availableItems}) {
    this.availableOffers = _generateOffers(availableOffers);

    //gives priority to Offers of type none
    this.availableOffers.sort((Offer offer1, Offer offer2) =>
        (offer1.offerType.index).compareTo(offer2.offerType.index));
  }

  //creates at least one Offer.None for each price,
  //This is a little workaround for
  List<Offer> _generateOffers(List<Offer> input) {
    return (input +
            input
                .map((offer) => OfferNone(
                    itemId: offer.itemId,
                    originalUnitPrice: offer.originalUnitPrice))
                .toList())
        .toSet()
        .toList();
  }

  //increments number of items with this itemid
  void addItem(int itemId, [int number = 1]) {
    items[itemId] = (items[itemId] ?? 0) + number;
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

  Price _getPriceForItemBestOffer(
      {required int itemId, required int itemCount}) {
    //Calculates prices for all available offers that match this item id
    return getOffersForItem(itemId: itemId)
        .map((e) => e.getPrice(itemCount: itemCount))
        //returns price with lowest final amount
        .reduce((price1, price2) =>
            price1.finalAmount < price2.finalAmount ? price1 : price2);
  }

  //Combines multiple offers and finds best price
  Price getPriceForItem({required int itemId, int? itemCount}) {
    //gets item count from list of items if item count is not specified
    itemCount = itemCount ?? items[itemId] ?? 0;

    Price priceFromBestOffer =
        _getPriceForItemBestOffer(itemId: itemId, itemCount: itemCount);

    int? offerUnits;

    if (priceFromBestOffer.bestOfferApplied is OfferMultibuy) {
      offerUnits =
          (priceFromBestOffer.bestOfferApplied as OfferMultibuy).offerUnits;
    }

    if (offerUnits == null) return priceFromBestOffer;

    int modulo = itemCount % offerUnits;

    if (modulo == 0) return priceFromBestOffer;

    return _getPriceForItemBestOffer(
            itemId: itemId, itemCount: itemCount - modulo) +
        _getPriceForItemBestOffer(itemId: itemId, itemCount: modulo);
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
