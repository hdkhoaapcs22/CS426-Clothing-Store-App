import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/class/expanded_item.dart';
import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:clothing_store_app/utils/themes.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  late List<ExpandedItem> _data;
  late String _selectedCategory;
  late TextEditingController _searchController;
  String _searchTerm = '';

  List<ExpandedItem> generateItems() {
    return [
      ExpandedItem(
        headerValue: AppLocalizations(context).of('question01'),
        expandedValue: AppLocalizations(context).of('answer01'),
        category: AppLocalizations(context).of("general"),
      ),
      ExpandedItem(
        headerValue: AppLocalizations(context).of('question02'),
        expandedValue: AppLocalizations(context).of('answer02'),
        category: AppLocalizations(context).of("general"),
      ),
      ExpandedItem(
        headerValue: AppLocalizations(context).of('question03'),
        expandedValue: AppLocalizations(context).of('answer03'),
        category: AppLocalizations(context).of("account"),
      ),
      ExpandedItem(
        headerValue: AppLocalizations(context).of('question04'),
        expandedValue: AppLocalizations(context).of('answer04'),
        category: AppLocalizations(context).of("notification"),
      ),
      ExpandedItem(
        headerValue: AppLocalizations(context).of('question05'),
        expandedValue: AppLocalizations(context).of('answer05'),
        category: AppLocalizations(context).of("general"),
      ),
      ExpandedItem(
        headerValue: AppLocalizations(context).of('question06'),
        expandedValue: AppLocalizations(context).of('answer06'),
        category: AppLocalizations(context).of("account"),
      ),
      ExpandedItem(
        headerValue: AppLocalizations(context).of('question07'),
        expandedValue: AppLocalizations(context).of('answer07'),
        category: AppLocalizations(context).of("general"),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _data = generateItems();
    _selectedCategory = AppLocalizations(context).of("all");
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("help_center"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: MediaQuery.of(context).size.width > 360
                          ? const EdgeInsets.symmetric(horizontal: 16.0)
                          : const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CommonTextField(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                        textFieldPadding:
                            const EdgeInsets.symmetric(vertical: 8.0),
                        focusColor: Colors.brown,
                        hintTextStyle:
                            TextStyles(context).getTextFieldHintStyle(),
                        textEditingController: _searchController,
                        prefixIconData: Icons.search,
                        hintText: AppLocalizations(context).of('search'),
                        onChanged: (value) {
                          setState(() {
                            _searchTerm = value;
                          });
                        },
                      ),
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: <Widget>[
                          TabBar(
                            indicatorColor: Colors.brown,
                            indicatorWeight: 6.0,
                            labelColor: Colors.brown,
                            unselectedLabelColor: Colors.grey,
                            labelStyle: TextStyles(context).getTabTextStyle(),
                            unselectedLabelStyle:
                                TextStyles(context).getTabTextStyle(),
                            tabs: [
                              Tab(text: AppLocalizations(context).of('faq')),
                              Tab(
                                  text: AppLocalizations(context)
                                      .of('contact_us')),
                            ],
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 200,
                            child: TabBarView(
                              children: [
                                _buildFaqList(),
                                _buildContactUsList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqList() {
    List<ExpandedItem> filteredItems = _data.where((item) {
      bool matchesCategory =
          _selectedCategory == AppLocalizations(context).of("all") ||
              item.category == _selectedCategory;
      bool matchesSearchTerm = _searchTerm.isEmpty ||
          item.headerValue.toLowerCase().contains(_searchTerm.toLowerCase());
      return matchesCategory && matchesSearchTerm;
    }).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).size.width > 360
            ? const EdgeInsets.all(8.0)
            : const EdgeInsets.all(4.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton(
                    category: AppLocalizations(context).of("all"),
                    selectedCategory: _selectedCategory,
                    onPressed: () {
                      setState(() {
                        _selectedCategory = AppLocalizations(context).of("all");
                      });
                    },
                    context: context,
                  ),
                  MediaQuery.of(context).size.width > 360
                      ? const SizedBox(width: 8.0)
                      : const SizedBox(width: 4.0),
                  _buildCategoryButton(
                    category: AppLocalizations(context).of("general"),
                    selectedCategory: _selectedCategory,
                    onPressed: () {
                      setState(() {
                        _selectedCategory =
                            AppLocalizations(context).of("general");
                      });
                    },
                    context: context,
                  ),
                  MediaQuery.of(context).size.width > 360
                      ? const SizedBox(width: 8.0)
                      : const SizedBox(width: 4.0),
                  _buildCategoryButton(
                    category: AppLocalizations(context).of("account"),
                    selectedCategory: _selectedCategory,
                    onPressed: () {
                      setState(() {
                        _selectedCategory =
                            AppLocalizations(context).of("account");
                      });
                    },
                    context: context,
                  ),
                  MediaQuery.of(context).size.width > 360
                      ? const SizedBox(width: 8.0)
                      : const SizedBox(width: 4.0),
                  _buildCategoryButton(
                    category: AppLocalizations(context).of("notification"),
                    selectedCategory: _selectedCategory,
                    onPressed: () {
                      setState(() {
                        _selectedCategory =
                            AppLocalizations(context).of("notification");
                      });
                    },
                    context: context,
                  ),
                ],
              ),
            ),
            MediaQuery.of(context).size.width > 360
                ? const SizedBox(height: 16.0)
                : const SizedBox(height: 8.0),
            Padding(
              padding: MediaQuery.of(context).size.width > 360
                  ? const EdgeInsets.symmetric(horizontal: 16.0)
                  : const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: ExpansionPanelList(
                    dividerColor: Colors.transparent,
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        filteredItems[index].isExpanded = isExpanded;
                      });
                    },
                    elevation: 0,
                    children:
                        filteredItems.map<ExpansionPanel>((ExpandedItem item) {
                      return ExpansionPanel(
                        backgroundColor: AppTheme.backgroundColor,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Padding(
                            padding: MediaQuery.of(context).size.width > 360
                                ? const EdgeInsets.all(8.0)
                                : const EdgeInsets.all(4.0),
                            child: ListTile(
                              title: Text(item.headerValue,
                                  style:
                                      TextStyles(context).getFAQHeaderStyle()),
                            ),
                          );
                        },
                        body: Column(
                          children: [
                            const Divider(color: Colors.grey),
                            Padding(
                              padding: MediaQuery.of(context).size.width > 360
                                  ? const EdgeInsets.all(8.0)
                                  : const EdgeInsets.all(4.0),
                              child: ListTile(
                                title: Text(item.expandedValue),
                              ),
                            ),
                          ],
                        ),
                        isExpanded: item.isExpanded,
                        canTapOnHeader: true,
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContactUsList() {
    final List<Map<String, dynamic>> contactMethods = [
      {
        'title': AppLocalizations(context).of('customer_service'),
        'icon': Localfiles.customerServiceIcon,
        'contact': '123-456'
      },
      {
        'title': AppLocalizations(context).of('whats_app'),
        'icon': Localfiles.whatsAppIcon,
        'contact': '(480) 555-0103'
      },
      {
        'title': AppLocalizations(context).of('website'),
        'icon': Localfiles.websiteIcon,
        'contact': 'www.example.com'
      },
      {
        'title': AppLocalizations(context).of('facebook'),
        'icon': Localfiles.facebookIcon2,
        'contact': 'www.facebook.com'
      },
      {
        'title': AppLocalizations(context).of('twitter'),
        'icon': Localfiles.twitterIcon,
        'contact': 'www.twitter.com'
      },
      {
        'title': AppLocalizations(context).of('instagram'),
        'icon': Localfiles.instagramIcon,
        'contact': 'www.instagram.com'
      },
    ];

    return Padding(
      padding: MediaQuery.of(context).size.width > 360
          ? const EdgeInsets.all(16.0)
          : const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: contactMethods.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: MediaQuery.of(context).size.width > 360
                ? const EdgeInsets.symmetric(vertical: 8.0)
                : const EdgeInsets.symmetric(vertical: 4.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  ExpansionTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage(contactMethods[index]['icon']),
                      radius: 20,
                    ),
                    title: Text(contactMethods[index]['title']),
                    children: [
                      const Divider(color: Colors.grey),
                      if (contactMethods[index]['contact'] != null)
                        ListTile(
                          title: Text(contactMethods[index]['contact']),
                          leading: const Icon(Icons.circle,
                              size: 10, color: Colors.brown),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryButton({
    required String category,
    required String selectedCategory,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedCategory == category ? Colors.brown : Colors.grey,
      ),
      child: Text(
        category,
        style: TextStyles(context)
            .getCategoryButtonStyle(selectedCategory == category),
      ),
    );
  }
}
