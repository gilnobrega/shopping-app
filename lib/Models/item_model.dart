class ItemModel {
  final int itemId;
  late String title;
  final String? description;
  final String? pictureUrl;

  ItemModel(
      {required this.itemId,
      required this.title,
      this.description,
      this.pictureUrl});
}
