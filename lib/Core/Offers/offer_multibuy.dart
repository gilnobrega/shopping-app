import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Enums/offer_type.dart';

//Base class for OfferMultibuyFixed and OfferMultibuyNforN
abstract class OfferMultibuy extends Offer {
  late final int offerUnits; //4 units

  OfferMultibuy(
      {required this.offerUnits,
      required int itemId,
      required int originalUnitPrice,
      required OfferType offerType})
      : super(
            itemId: itemId,
            offerType: offerType,
            originalUnitPrice: originalUnitPrice);
}
