import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Enums/offer_type.dart';

class OfferSingle extends Offer {
  final int discountedAmount;

  OfferSingle(
      {required offerId,
      required this.discountedAmount,
      required int originalUnitPrice})
      : super(
            offerId: offerId,
            offerType: OfferType.single,
            originalUnitPrice: originalUnitPrice);

  @override
  int calculateFinalPrice({int? itemCount}) =>
      (itemCount ?? 0) * (originalUnitPrice - discountedAmount);
}
