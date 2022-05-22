import 'package:shopping_app/Core/offer.dart';
import 'package:shopping_app/Enums/offer_type.dart';

class OfferSingle extends Offer {
  final int discountedAmount;

  OfferSingle({required offerId, required this.discountedAmount})
      : super(offerId: offerId, offerType: OfferType.single);

  @override
  int calculateDiscount({int? itemCount, int? originalPrice}) =>
      (itemCount ?? 0) * discountedAmount;
}
