import 'package:shopping_app/Core/offer.dart';
import 'package:shopping_app/Enums/offer_type.dart';

//E.g.: 4 for 3
class OfferMultibuyNForN extends Offer {
  late final int offerUnits; //4 units
  late final int forUnits; //3 units

  OfferMultibuyNForN(
      {required this.offerUnits,
      required this.forUnits,
      required int offerId,
      required int originalUnitPrice})
      : super(
            offerId: offerId,
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
