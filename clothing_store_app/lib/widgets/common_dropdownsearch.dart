import 'package:flutter/material.dart';
import '../utils/text_styles.dart';

class CommonDropdownSearch<T> extends StatefulWidget {
  final List<T> items;
  final String hintText;
  final T? selectedItem;
  final Function(T?)? onChanged;
  final String Function(T)? itemAsString;
  final bool isBottomSheet;

  CommonDropdownSearch({
    required this.items,
    required this.hintText,
    this.selectedItem,
    this.onChanged,
    this.itemAsString,
    this.isBottomSheet = false,
  });

  @override
  _CommonDropdownSearchState<T> createState() =>
      _CommonDropdownSearchState<T>();
}

class _CommonDropdownSearchState<T> extends State<CommonDropdownSearch<T>> {
  late TextEditingController _searchController;
  late ValueNotifier<List<T>> _filteredItems;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = ValueNotifier<List<T>>(widget.items);
    _searchController.addListener(_filterItems);
  }

  @override
  void didUpdateWidget(CommonDropdownSearch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _filteredItems.value = widget.items;
      _filterItems();
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterItems);
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    print(query);
    _filteredItems.value = widget.items.where((item) {
      final itemString = widget.itemAsString?.call(item) ?? item.toString();
      return itemString.toLowerCase().contains(query);
    }).toList();
  }

  void _showDropdown(BuildContext context) {
    if (widget.isBottomSheet) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return _buildDropdownList();
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: _buildDropdownList(),
          );
        },
      );
    }
  }

  Widget _buildDropdownList() {
    return ValueListenableBuilder<List<T>>(
      valueListenable: _filteredItems,
      builder: (context, items, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _filterItems();
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(
                        widget.itemAsString?.call(item) ?? item.toString()),
                    onTap: () {
                      if (widget.onChanged != null) {
                        widget.onChanged!(item);
                      }

                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDropdown(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.hintText,
          border: OutlineInputBorder(),
        ),
        child: Text(
          widget.selectedItem != null
              ? widget.itemAsString?.call(widget.selectedItem!) ??
                  widget.selectedItem.toString()
              : '',
          style: TextStyles(context).getRegularStyle(),
        ),
      ),
    );
  }
}
