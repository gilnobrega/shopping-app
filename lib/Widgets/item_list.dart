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
      required this.isCheckoutScreen,
      this.animatedListStateKey})
      : super(key: key);
  final Function(ItemModel) viewDetails;
  final CartModel cart;
  final List<ItemModel> availableItems;
  final VoidCallback setState;
  final bool isCheckoutScreen;
  final GlobalKey<AnimatedListState>? animatedListStateKey;

  @override
  State<ItemList> createState() => ItemListState();
}

class ItemListState extends State<ItemList> {
  late List<ItemModel> initialCart;

  @override
  void initState() {
    initialCart = widget.availableItems;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCheckoutScreen) {
      return AnimatedList(
        key: widget.animatedListStateKey,
        initialItemCount: widget.availableItems.length,
        itemBuilder: builder,
      );
    }

    return ListView.builder(
        itemCount: widget.availableItems.length, itemBuilder: _listTileBuilder);
  }

  Widget builder(BuildContext context, int index, Animation<double> animation) {
    return ClipRect(
        child: SlideTransition(
            position: Tween<Offset>(
                    begin: const Offset(-1.0, 0), end: const Offset(0, 0))
                .animate(animation),
            child: _listTileBuilder(context, index)));
  }

  Widget _listTileBuilder(BuildContext context, int index) {
    ItemModel item = widget.availableItems.length > index
        ? widget.availableItems[index]
        : initialCart[index];
    List<Offer> offers =
        widget.cart.getOffersForItem(itemId: item.itemId).toList();

    return ItemTile(
        cart: widget.cart,
        setState: () => widget.setState(),
        isCheckoutScreen: widget.isCheckoutScreen,
        item: item,
        currency: widget.cart.currency,
        pricePerUnit:
            widget.cart.getPriceForItem(itemId: item.itemId, itemCount: 1),
        totalPrice: widget.cart.getPriceForItem(itemId: item.itemId),
        count: widget.cart.items[item.itemId] ?? 0,
        offers: offers,
        addItem: () => addItem(item.itemId),
        removeItem: () => removeItem(item),
        viewDetails: () {
          widget.viewDetails(item);
        });
  }

  void addItem(int itemId) {
    widget.cart.addItem(itemId);
    widget.setState();
  }

  void removeItem(ItemModel item) {
    if (widget.isCheckoutScreen &&
        widget.cart.items.containsKey(item.itemId) &&
        widget.cart.items[item.itemId]! == 1) {
      int index = widget.availableItems.indexOf(item);

      widget.animatedListStateKey?.currentState?.removeItem(
          index, (context, animation) => builder(context, index, animation));
    }
    widget.cart.removeItem(item.itemId);
    widget.setState();

    initialCart = widget.availableItems;
  }
}
