import 'package:shopping_app/Core/offer.dart';
import 'package:shopping_app/Enums/offer_type.dart';

//E.g.: 4 for 3
class OfferMultibuyNForN extends Offer {
  late final int offerUnits; //4 units
  late final int forUnits; //3 units

  OfferMultibuyNForN(
      {required this.offerUnits, required this.forUnits, required int offerId})
      : super(offerId: offerId, offerType: OfferType.multiBuyNForN);

  @override
  int calculateDiscount({int? itemCount, int? originalPrice}) {
    if (itemCount == null || originalPrice == null) return 0;

    int itemsNotCoveredByOffer = itemCount % offerUnits;

    return (itemCount - itemsNotCoveredByOffer) * (forUnits * originalPrice) +
        (itemsNotCoveredByOffer * originalPrice);
  }
}
