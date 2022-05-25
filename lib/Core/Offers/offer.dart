import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Enums/offer_type.dart';

abstract class Offer {
  final int itemId;
  final OfferType offerType;
  final int originalUnitPrice;

  Offer(
      {required this.itemId,
      required this.offerType,
      required this.originalUnitPrice}) {
    if (originalUnitPrice < 0) {
      throw Exception("Original price $originalUnitPrice cannot be negative");
    }
  }

  //Price before offer is applied
  int _calculateOriginalPrice({int? itemCount}) =>
      (itemCount ?? 0) * originalUnitPrice;
  //Price after offer is applied
  int calculateFinalPrice({int? itemCount});

  Price getPrice({int? itemCount}) => Price(
      originalAmount: _calculateOriginalPrice(itemCount: itemCount),
      finalAmount: calculateFinalPrice(itemCount: itemCount),
      offersApplied: [this]);
}
