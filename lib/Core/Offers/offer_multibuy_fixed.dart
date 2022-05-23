import 'package:shopping_app/Core/Offers/offer_multibuy.dart';
import 'package:shopping_app/Enums/offer_type.dart';

//E.g.: 4 for 2£
class OfferMultibuyFixed extends OfferMultibuy {
  late final int offerAmount; //200 (2£)

  OfferMultibuyFixed(
      {required int offerUnits,
      required this.offerAmount,
      required int itemId,
      required int originalUnitPrice})
      : super(
            itemId: itemId,
            offerUnits: offerUnits,
            offerType: OfferType.multiBuyFixed,
            originalUnitPrice: originalUnitPrice) {
    if (offerAmount < 0) {
      throw Exception("Offer amount $offerAmount cannot be negative");
    }
  }

  @override
  int calculateFinalPrice({int? itemCount}) {
    if (itemCount == null) return 0;

    int numberOfOffers = (itemCount / offerUnits).floor();
    int itemsNotCoveredByOffer = itemCount % offerUnits;

    return numberOfOffers * offerAmount +
        (itemsNotCoveredByOffer * originalUnitPrice);
  }
}
