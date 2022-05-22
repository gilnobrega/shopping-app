import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Enums/offer_type.dart';

class OfferNone extends Offer {
  OfferNone({required int itemId, required int originalUnitPrice})
      : super(
            itemId: itemId,
            offerType: OfferType.none,
            originalUnitPrice: originalUnitPrice);

  @override
  int calculateFinalPrice({int? itemCount}) =>
      (itemCount ?? 0) * originalUnitPrice;
}
