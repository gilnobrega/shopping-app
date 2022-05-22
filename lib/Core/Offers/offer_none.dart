import 'package:shopping_app/Core/offer.dart';
import 'package:shopping_app/Enums/offer_type.dart';

class OfferNone extends Offer {
  OfferNone({required offerId})
      : super(offerId: offerId, offerType: OfferType.none);

  @override
  int calculateDiscount({int? itemCount, int? originalPrice}) => 0;
}
