import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile.dart';

class ItemList extends StatefulWidget {
  const ItemList(
      {Key? key,
      required this.viewDetails,
      required this.cart,
      required this.availableItems,
      required this.setState,
      required this.isCheckoutScreen})
      : super(key: key);
  final Function(ItemModel) viewDetails;
  final CartModel cart;
  final List<ItemModel> availableItems;
  final VoidCallback setState;
  final bool isCheckoutScreen;

  @override
  State<ItemList> createState() => ItemListState();
}

class ItemListState extends State<ItemList> {
  late int initialCount;
  late List<ItemModel> initialCart;

  final key = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    initialCount = widget.availableItems.length;
    initialCart = widget.availableItems;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: widget.isCheckoutScreen ? key : null,
      initialItemCount: initialCount,
      itemBuilder: builder,
    );
  }

  Widget builder(BuildContext context, int index, Animation<double> animation) {
    ItemModel item = initialCart[index];
    List<Offer> offers =
        widget.cart.getOffersForItem(itemId: item.itemId).toList();

    return ClipRect(
        child: SlideTransition(
            position: Tween<Offset>(
                    begin: const Offset(-1.0, 0), end: const Offset(0, 0))
                .animate(animation),
            key: Key(UniqueKey().toString()),
            child: ItemTile(
                item: item,
                currency: widget.cart.currency,
                pricePerUnit: widget.cart
                    .getPriceForItem(itemId: item.itemId, itemCount: 1),
                totalPrice: widget.cart.getPriceForItem(itemId: item.itemId),
                count: widget.cart.items[item.itemId] ?? 0,
                offers: offers,
                addItem: () => addItem(item.itemId),
                removeItem: () => removeItem(index, item.itemId),
                viewDetails: () {
                  widget.viewDetails(item);
                })));
  }

  void addItem(int itemId) {
    setState(() {
      widget.cart.addItem(itemId);
    });
    widget.setState();
  }

  void removeItem(int index, int itemId) {
    setState(() {
      if (widget.isCheckoutScreen &&
          widget.cart.items.containsKey(itemId) &&
          widget.cart.items[itemId]! == 1) {
        key.currentState!.removeItem(
            index, (context, animation) => builder(context, index, animation));
      }
      widget.cart.removeItem(itemId);
    });
    widget.setState();
  }
}
