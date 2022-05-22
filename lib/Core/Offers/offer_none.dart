import 'package:shopping_app/Core/offer.dart';
import 'package:shopping_app/Enums/offer_type.dart';

class OfferNone extends Offer {
  OfferNone({required offerId, required int originalUnitPrice})
      : super(
            offerId: offerId,
            offerType: OfferType.none,
            originalUnitPrice: originalUnitPrice);

  @override
  int calculateFinalPrice({int? itemCount}) =>
      (itemCount ?? 0) * originalUnitPrice;
}
