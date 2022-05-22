class Price {
  final int originalAmount;
  final int finalAmount;

  int get discountedAmount => originalAmount - finalAmount;

  Price({required this.originalAmount, required this.finalAmount});
}
