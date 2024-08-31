import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/providers/filter_provider.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> brands = ['All', 'Uniqlo', 'Nike', 'Addidas', 'Puma'];
  List<String> genders = ['All', 'Men', 'Women'];
  List<String> sortbys = ['Popular', 'Price High'];

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(builder: (context, filterProvider, _) {
      int chosenBrandIndex = filterProvider.chosenBrandIndex;
      int chosenGenderIndex = filterProvider.chosenGenderIndex;
      int chosenSortIndex = filterProvider.chosenSortIndex;

      return Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                )
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    filterProvider.resetFilter();
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(160, 50),
                    backgroundColor: const Color.fromARGB(255, 211, 211, 211),
                  ),
                  child: const Text('Reset filter',
                      style: TextStyle(
                          fontSize: 18, color: Color.fromRGBO(88, 57, 39, 1))),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //       fixedSize: const Size(160, 50),
              //       backgroundColor: const Color.fromRGBO(88, 57, 39, 1),
              //     ),
              //     child: const Text('Apply',
              //         style: TextStyle(fontSize: 18, color: Colors.white)),
              //   ),
              // )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonDetailedAppBarView(
                    onPrefixIconClick: () {
                      Navigator.pop(context);
                    },
                    title: AppLocalizations(context).of("filter"),
                    prefixIconData: Icons.arrow_back),
                const Padding(padding: EdgeInsets.all(8)),
                Row(
                  children: [
                    Text(
                      AppLocalizations(context).of("brand"),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(2)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ListView.builder(
                    itemCount: brands.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.055,
                          child: ElevatedButton(
                            onPressed: () {
                              filterProvider.updateBrandIndex(index);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: chosenBrandIndex == index
                                    ? const Color.fromRGBO(88, 57, 39, 1)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: Text(brands[index],
                                style: TextStyle(
                                    fontSize: 16,
                                    color: chosenBrandIndex == index
                                        ? Colors.white
                                        : const Color.fromRGBO(88, 57, 39, 1))),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Row(
                  children: [
                    Text(
                      AppLocalizations(context).of("gender"),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(2)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ListView.builder(
                    itemCount: genders.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.055,
                          child: ElevatedButton(
                            onPressed: () {
                              filterProvider.updateGenderIndex(index);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: chosenGenderIndex == index
                                    ? const Color.fromRGBO(88, 57, 39, 1)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: Text(genders[index],
                                style: TextStyle(
                                    fontSize: 16,
                                    color: chosenGenderIndex == index
                                        ? Colors.white
                                        : const Color.fromRGBO(88, 57, 39, 1))),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Row(
                  children: [
                    Text(
                      AppLocalizations(context).of("sort_by"),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(2)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ListView.builder(
                    itemCount: sortbys.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.055,
                          child: ElevatedButton(
                            onPressed: () {
                              filterProvider.updateSortIndex(index);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: chosenSortIndex == index
                                    ? const Color.fromRGBO(88, 57, 39, 1)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: Text(sortbys[index],
                                style: TextStyle(
                                    fontSize: 16,
                                    color: chosenSortIndex == index
                                        ? Colors.white
                                        : const Color.fromRGBO(88, 57, 39, 1))),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Row(
                  children: [
                    Text(
                      AppLocalizations(context).of("price_range"),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(2)),
                Row(
                  children: [
                    const Text(
                      '0',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: RangeSlider(
                        activeColor: const Color.fromRGBO(88, 57, 39, 1),
                        inactiveColor: const Color.fromARGB(255, 211, 211, 211),
                        values: filterProvider.priceRange,
                        onChanged: (RangeValues newRange) {
                          filterProvider.updatePricerange(newRange);
                        },
                        min: 0.0,
                        max: 150.0,
                        divisions: 5,
                        labels: RangeLabels(
                            '${filterProvider.priceRange.start}',
                            '${filterProvider.priceRange.end}'),
                      ),
                    ),
                    const Text(
                      '150',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations(context).of("reviews"),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(2)),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color.fromRGBO(88, 57, 39, 1),
                  title: Row(
                    children: [
                      Icon(
                        Iconsax.star1,
                        color: AppTheme.yellowColor,
                        size: 16,
                      ),
                      Icon(
                        Iconsax.star1,
                        color: AppTheme.yellowColor,
                        size: 16,
                      ),
                      Icon(
                        Iconsax.star1,
                        color: AppTheme.yellowColor,
                        size: 16,
                      ),
                      Icon(
                        Iconsax.star1,
                        color: AppTheme.yellowColor,
                        size: 16,
                      ),
                      const Padding(padding: EdgeInsets.all(4)),
                      const Text(
                        '4.0 and above',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  value: '4',
                  groupValue: filterProvider.reviewpoint,
                  onChanged: (value) {
                    filterProvider.updateReviewOption(value.toString());
                  },
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color.fromRGBO(88, 57, 39, 1),
                  title: Row(
                    children: [
                      Icon(
                        Iconsax.star1,
                        color: AppTheme.yellowColor,
                        size: 16,
                      ),
                      Icon(
                        Iconsax.star1,
                        color: AppTheme.yellowColor,
                        size: 16,
                      ),
                      Icon(
                        Iconsax.star1,
                        color: AppTheme.yellowColor,
                        size: 16,
                      ),
                      const Padding(padding: EdgeInsets.all(4)),
                      const Text(
                        '3.0 and above',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  value: '3',
                  groupValue: filterProvider.reviewpoint,
                  onChanged: (value) {
                    filterProvider.updateReviewOption(value.toString());
                  },
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color.fromRGBO(88, 57, 39, 1),
                  title: Row(
                    children: [
                      Icon(
                        Iconsax.star1,
                        color: AppTheme.yellowColor,
                        size: 16,
                      ),
                      Icon(
                        Iconsax.star1,
                        color: AppTheme.yellowColor,
                        size: 16,
                      ),
                      const Padding(padding: EdgeInsets.all(4)),
                      const Text(
                        '2.0 and above',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  value: '2',
                  groupValue: filterProvider.reviewpoint,
                  onChanged: (value) {
                    filterProvider.updateReviewOption(value.toString());
                  },
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color.fromRGBO(88, 57, 39, 1),
                  title: Row(
                    children: [
                      Icon(
                        Iconsax.star1,
                        color: AppTheme.yellowColor,
                        size: 16,
                      ),
                      const Padding(padding: EdgeInsets.all(4)),
                      const Text(
                        '1.0 and above',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  value: '1',
                  groupValue: filterProvider.reviewpoint,
                  onChanged: (value) {
                    filterProvider.updateReviewOption(value.toString());
                  },
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color.fromRGBO(88, 57, 39, 1),
                  title: const Row(
                    children: [
                      Padding(padding: EdgeInsets.all(4)),
                      Text(
                        'All',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  value: '0',
                  groupValue: filterProvider.reviewpoint,
                  onChanged: (value) {
                    filterProvider.updateReviewOption(value.toString());
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
