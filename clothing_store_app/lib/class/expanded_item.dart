class ExpandedItem {
  ExpandedItem({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
    required this.category,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  String category;
}
