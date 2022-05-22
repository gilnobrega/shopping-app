class ItemModel {
  final int itemId;
  late String title;
  final String? description;
  final String? pictureUrl;

  final int offerId;

  ItemModel(
      {required this.itemId,
      required this.title,
      this.description,
      required this.offerId,
      this.pictureUrl});
}
