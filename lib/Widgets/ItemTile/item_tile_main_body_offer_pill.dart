import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_fixed.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_n_for_n.dart';
import 'package:shopping_app/Core/Offers/offer_single.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Enums/offer_type.dart';

class ItemTileMainBodyOfferPill extends StatelessWidget {
  const ItemTileMainBodyOfferPill(
      {Key? key,
      required this.offer,
      required this.currency,
      required this.offerIsApplied})
      : super(key: key);

  final Offer offer;
  final Currency currency;
  final bool offerIsApplied;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
        scale: offerIsApplied ? 1.0 : 0.95,
        duration: const Duration(milliseconds: 250),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
          margin: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: (offerIsApplied)
                  ? Theme.of(context).buttonTheme.colorScheme!.primary
                  : Theme.of(context).buttonTheme.colorScheme!.background),
          child: Text(_buildOfferString(offer),
              style: const TextStyle(color: Colors.white)),
        ));
  }

  String _buildOfferString(Offer offer) {
    switch (offer.offerType) {
      case OfferType.single:
        OfferSingle offerSingle = offer as OfferSingle;
        return "${currency.displayAmount(amount: offerSingle.discountedAmount)} off";

      case OfferType.multiBuyFixed:
        OfferMultibuyFixed offerMultibuyFixed = offer as OfferMultibuyFixed;
        return "${offerMultibuyFixed.offerUnits} for ${currency.displayAmount(amount: offerMultibuyFixed.offerAmount)}";

      case OfferType.multiBuyNForN:
        OfferMultibuyNForN offerMultibuyNForN = offer as OfferMultibuyNForN;
        return "${offerMultibuyNForN.offerUnits} for ${offerMultibuyNForN.forUnits}";

      default:
        return "";
    }
  }
}
