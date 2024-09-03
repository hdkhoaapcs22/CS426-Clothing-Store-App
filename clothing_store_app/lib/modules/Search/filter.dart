import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/providers/filter_provider.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
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
  List<String> sortbys = ['Popular', 'Low Price'];
  bool initialized = false;
  int chosenBrandIndex = 0;
  int chosenGenderIndex = 0;
  int chosenSortIndex = 0;
  RangeValues chosenPriceRange = const RangeValues(0, 150);
  String chosenReview = '0';

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(builder: (context, filterProvider, _) {
      if (initialized == false) {
        chosenBrandIndex = filterProvider.curBrand;
        chosenGenderIndex = filterProvider.curGender;
        chosenSortIndex = filterProvider.curSort;
        chosenPriceRange = filterProvider.curPrice;
        chosenReview = filterProvider.curReview;
        initialized = true;
      }

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
                child: CommonButton(
                  onTap: () {
                    setState(() {
                      chosenBrandIndex = 0;
                      chosenGenderIndex = 0;
                      chosenSortIndex = 0;
                      chosenPriceRange = const RangeValues(0, 150);
                      chosenReview = '0';
                    });
                  },
                  height: 50,
                  width: 160,
                  radius: 30.0,
                  backgroundColor: const Color.fromARGB(255, 211, 211, 211),
                  buttonTextWidget: const Text('Reset filter',
                      style: TextStyle(
                          fontSize: 18, color: Color.fromRGBO(88, 57, 39, 1))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CommonButton(
                  onTap: () {
                    filterProvider.applyFilter(
                        chosenBrandIndex,
                        chosenGenderIndex,
                        chosenSortIndex,
                        chosenPriceRange,
                        chosenReview);
                  },
                  height: 50,
                  width: 160,
                  radius: 30.0,
                  backgroundColor: const Color.fromRGBO(88, 57, 39, 1),
                  buttonTextWidget: const Text('Apply',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
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
                        child: CommonButton(
                          onTap: () {
                            setState(() {
                              chosenBrandIndex = index;
                            });
                          },
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: 90,
                          radius: 30.0,
                          backgroundColor: chosenBrandIndex == index
                              ? const Color.fromRGBO(88, 57, 39, 1)
                              : Colors.white,
                          buttonTextWidget: Text(brands[index],
                              style: TextStyle(
                                  fontSize: 16,
                                  color: chosenBrandIndex == index
                                      ? Colors.white
                                      : const Color.fromRGBO(88, 57, 39, 1))),
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
                        child: CommonButton(
                          onTap: () {
                            setState(() {
                              chosenGenderIndex = index;
                            });
                          },
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: 90,
                          radius: 30.0,
                          backgroundColor: chosenGenderIndex == index
                              ? const Color.fromRGBO(88, 57, 39, 1)
                              : Colors.white,
                          buttonTextWidget: Text(genders[index],
                              style: TextStyle(
                                  fontSize: 16,
                                  color: chosenGenderIndex == index
                                      ? Colors.white
                                      : const Color.fromRGBO(88, 57, 39, 1))),
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
                        child: CommonButton(
                          onTap: () {
                            setState(() {
                              chosenSortIndex = index;
                            });
                          },
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: 100,
                          radius: 30.0,
                          backgroundColor: chosenSortIndex == index
                              ? const Color.fromRGBO(88, 57, 39, 1)
                              : Colors.white,
                          buttonTextWidget: Text(sortbys[index],
                              style: TextStyle(
                                  fontSize: 16,
                                  color: chosenSortIndex == index
                                      ? Colors.white
                                      : const Color.fromRGBO(88, 57, 39, 1))),
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
                        values: chosenPriceRange,
                        onChanged: (RangeValues newRange) {
                          setState(() {
                            chosenPriceRange = newRange;
                          });
                        },
                        min: 0.0,
                        max: 150.0,
                        divisions: 5,
                        labels: RangeLabels('${chosenPriceRange.start}',
                            '${chosenPriceRange.end}'),
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
                reviewOption(4, '4.0 and above', '4'),
                reviewOption(3, '3.0 and above', '3'),
                reviewOption(2, '2.0 and above', '2'),
                reviewOption(1, '1.0 and above', '1'),
                reviewOption(0, 'All', '0'),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget reviewOption(int numStar, String text, String value) {
    return RadioListTile(
      contentPadding: EdgeInsets.zero,
      activeColor: const Color.fromRGBO(88, 57, 39, 1),
      title: Row(
        children: [
          for (int i = 0; i < numStar; ++i)
            Icon(
              Iconsax.star1,
              color: AppTheme.yellowColor,
              size: 16,
            ),
          const Padding(padding: EdgeInsets.all(4)),
          Text(
            text,
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
      value: value,
      groupValue: chosenReview,
      onChanged: (value) {
        setState(() {
          chosenReview = value!;
        });
      },
    );
  }
}
