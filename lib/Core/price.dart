class Price {
  final int originalAmount;
  final int finalAmount;

  int get discountedAmount => originalAmount - finalAmount;

  Price({required this.originalAmount, required this.finalAmount}) {
    if (originalAmount < 0) {
      throw Exception("Original amount $originalAmount cannot be negative");
    }

    if (finalAmount < 0) {
      throw Exception("Final amount $finalAmount cannot be negative");
    }

    if (originalAmount < finalAmount) {
      throw Exception(
          "Original amount $originalAmount cannot be less than final amount $finalAmount");
    }
  }

  Price operator +(Price otherPrice) {
    return Price(
        finalAmount: finalAmount + otherPrice.finalAmount,
        originalAmount: originalAmount + otherPrice.originalAmount);
  }
}
