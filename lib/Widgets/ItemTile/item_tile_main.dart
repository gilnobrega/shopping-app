import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile_icon.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile_main_body_offer_pill.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile_price.dart';

class ItemTileMainBody extends StatelessWidget {
  const ItemTileMainBody(
      {Key? key,
      required this.offers,
      required this.item,
      required this.currency,
      required this.pricePerUnit,
      required this.totalPrice,
      required this.viewDetails,
      required this.isCheckoutScreen,
      required this.cart,
      required this.setState})
      : super(key: key);

  final List<Offer> offers;
  final ItemModel item;
  final Currency currency;
  final Price pricePerUnit;
  final Price totalPrice;
  final VoidCallback viewDetails;
  final VoidCallback setState;
  final bool isCheckoutScreen;
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: offers.isNotEmpty,
      leading: Container(
          margin: const EdgeInsets.only(right: 24.0),
          child: ItemTileIcon(item: item)),
      title: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
        Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: Text(
              item.title,
              textScaleFactor: 1.2,
            )),
        Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: ItemTilePrice(
              currency: currency,
              price: !isCheckoutScreen
                  ? pricePerUnit.originalAmount
                  : totalPrice.finalAmount,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .color!
                      .withAlpha(128)),
            )),
      ]),
      subtitle: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const SizedBox(width: double.infinity, height: 4.0),
          ...offers.map((offer) => ItemTileMainBodyOfferPill(
                setState: setState,
                cart: cart,
                offerIsApplied: totalPrice.finalAmount != 0 &&
                    (totalPrice.offersApplied?.contains(offer) ?? false),
                offer: offer,
                currency: currency,
              )),
          if (isCheckoutScreen && offers.isNotEmpty) ...[
            const SizedBox(width: double.infinity, height: 4.0),
            Container(
                padding: const EdgeInsets.only(left: 4),
                child: ItemTilePrice(
                  currency: currency,
                  price: totalPrice.discountedAmount,
                  onlyFade: true,
                  appendStringBeginning: "saving ",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.red[200]!),
                )),
          ],
        ],
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dense: false,
      onTap: viewDetails,
      minVerticalPadding: 16.0,
    );
  }
}
