import 'package:shopping_app/Core/Offers/offer_multibuy.dart';
import 'package:shopping_app/Enums/offer_type.dart';

//E.g.: 4 for 3
class OfferMultibuyNForN extends OfferMultibuy {
  late final int forUnits; //3 units

  OfferMultibuyNForN(
      {required int offerUnits,
      required this.forUnits,
      required int itemId,
      required int originalUnitPrice})
      : super(
            itemId: itemId,
            offerUnits: offerUnits,
            offerType: OfferType.multiBuyNForN,
            originalUnitPrice: originalUnitPrice);

  @override
  int calculateFinalPrice({int? itemCount}) {
    if (itemCount == null) return 0;

    int numberOfOffers = (itemCount / offerUnits).floor();
    int itemsNotCoveredByOffer = itemCount % offerUnits;

    return numberOfOffers * (forUnits * originalUnitPrice) +
        (itemsNotCoveredByOffer * originalUnitPrice);
  }
}
