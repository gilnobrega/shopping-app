import 'package:shopping_app/Enums/offer_type.dart';

abstract class Offer {
  final int offerId;
  final OfferType offerType;

  Offer({required this.offerId, required this.offerType});

  int calculateDiscount({int? itemCount, int? originalPrice});
}
