import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/item_tile_main_body_offer_pill.dart';

class ItemTileMainBody extends StatelessWidget {
  const ItemTileMainBody(
      {Key? key,
      required this.offers,
      required this.item,
      required this.currency,
      required this.pricePerUnit,
      required this.totalPrice})
      : super(key: key);

  final List<Offer> offers;
  final ItemModel item;
  final Currency currency;
  final Price pricePerUnit;
  final Price totalPrice;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: offers.isNotEmpty,
      leading: item.pictureUrl == null
          ? const Icon(Icons.question_mark)
          : Image.network(item.pictureUrl!),
      title: Text(
        item.title,
        textScaleFactor: 1.2,
      ),
      subtitle: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 4.0),
              child: Text(
                  currency.displayAmount(amount: pricePerUnit.originalAmount))),
          ...offers.map((offer) => ItemTileMainBodyOfferPill(
                offerIsApplied: totalPrice.finalAmount != 0 &&
                    offer == totalPrice.offerApplied,
                offer: offer,
                currency: currency,
              ))
        ],
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dense: false,
      onTap: () {},
      minVerticalPadding: 12.0,
    );
  }
}
