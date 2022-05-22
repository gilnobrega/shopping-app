import 'package:shopping_app/Core/offer.dart';
import 'package:shopping_app/Enums/offer_type.dart';

//E.g.: 4 for 2£
class OfferMultibuyFixed extends Offer {
  late final int offerUnits; //4 units
  late final int offerAmount; //200 (2£)

  OfferMultibuyFixed(
      {required this.offerUnits,
      required this.offerAmount,
      required int offerId})
      : super(offerId: offerId, offerType: OfferType.multiBuyFixed);

  @override
  int calculateDiscount({int? itemCount, int? originalPrice}) {
    if (itemCount == null || originalPrice == null) return 0;

    int itemsNotCoveredByOffer = itemCount % offerUnits;

    return (itemCount - itemsNotCoveredByOffer) * offerAmount +
        (itemsNotCoveredByOffer * originalPrice);
  }
}
