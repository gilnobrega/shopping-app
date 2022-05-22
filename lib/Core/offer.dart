import 'package:shopping_app/Enums/offer_type.dart';

abstract class Offer {
  final int offerId;
  final OfferType offerType;
  final int originalUnitPrice;

  Offer(
      {required this.offerId,
      required this.offerType,
      required this.originalUnitPrice});

  //Price before offer is applied
  int calculateOriginalPrice({int? itemCount}) =>
      (itemCount ?? 0) * originalUnitPrice;
  //Discount
  int calculateDiscount({int? itemCount});
  //Price after offer is applied
  int calculateFinalPrice({int? itemCount}) =>
      calculateOriginalPrice(itemCount: itemCount) -
      calculateDiscount(itemCount: itemCount);
}
