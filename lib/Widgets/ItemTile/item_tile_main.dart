import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile_icon.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile_main_body_offer_pill.dart';

class ItemTileMainBody extends StatelessWidget {
  const ItemTileMainBody(
      {Key? key,
      required this.offers,
      required this.item,
      required this.currency,
      required this.pricePerUnit,
      required this.totalPrice,
      required this.viewDetails})
      : super(key: key);

  final List<Offer> offers;
  final ItemModel item;
  final Currency currency;
  final Price pricePerUnit;
  final Price totalPrice;
  final VoidCallback viewDetails;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: offers.isNotEmpty,
      leading: item.pictureUrl == null
          ? const Icon(Icons.question_mark)
          : ItemTileIcon(item: item),
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
              child: Text(currency.displayAmount(
                  amount: totalPrice.originalAmount == 0
                      ? pricePerUnit.originalAmount
                      : totalPrice.originalAmount))),
          ...offers.map((offer) => ItemTileMainBodyOfferPill(
                offerIsApplied: totalPrice.finalAmount != 0 &&
                    offer == totalPrice.offerApplied,
                offer: offer,
                currency: currency,
              )),
          if (totalPrice.discountedAmount > 0) ...[
            const SizedBox(width: double.infinity),
            Container(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  'saving ${currency.displayAmount(amount: totalPrice.discountedAmount)}',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.red[200]!),
                )),
          ]
        ],
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dense: false,
      onTap: viewDetails,
      minVerticalPadding: 12.0,
    );
  }
}
