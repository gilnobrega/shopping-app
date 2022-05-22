import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_fixed.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_n_for_n.dart';
import 'package:shopping_app/Core/Offers/offer_single.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Enums/offer_type.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/item_tile_main_body_offer_pill.dart';

class ItemTileMainBody extends StatelessWidget {
  const ItemTileMainBody(
      {Key? key,
      this.offer,
      required this.item,
      required this.currency,
      required this.price})
      : super(key: key);

  final Offer? offer;
  final ItemModel item;
  final Currency currency;
  final Price price;

  @override
  Widget build(BuildContext context) {
    String? offerString = _buildOfferString();

    return ListTile(
      isThreeLine: offerString != null,
      leading: item.pictureUrl == null
          ? const Icon(Icons.question_mark)
          : Image.network(item.pictureUrl!),
      title: Text(
        item.title,
        textScaleFactor: 1.2,
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(currency.displayAmount(amount: price.finalAmount)),
          if (offerString != null)
            ItemTileMainBodyOfferPill(offerString: offerString)
        ],
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dense: false,
      onTap: () {},
      minVerticalPadding: 12.0,
    );
  }

  String? _buildOfferString() {
    if (offer == null) return null;

    switch (offer!.offerType) {
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
        return null;
    }
  }
}
