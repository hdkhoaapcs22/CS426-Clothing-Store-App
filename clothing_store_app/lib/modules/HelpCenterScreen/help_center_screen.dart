import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'category_button.dart';
import 'package:clothing_store_app/utils/text_styles.dart';

class HelpCenterScreen extends StatefulWidget {
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  late List<Item> _data;
  late String _selectedCategory;
  late TextEditingController _searchController;
  String _searchTerm = '';

  List<Item> generateItems() {
    return [
      Item(
        headerValue: AppLocalizations(context).of('question01'),
        expandedValue:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        category: 'General',
      ),
      Item(
        headerValue: AppLocalizations(context).of('question02'),
        expandedValue:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        category: 'General',
      ),
      Item(
        headerValue: AppLocalizations(context).of('question03'),
        expandedValue:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        category: 'Account',
      ),
      Item(
        headerValue: AppLocalizations(context).of('question04'),
        expandedValue:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        category: 'Notification',
      ),
      Item(
        headerValue: AppLocalizations(context).of('question05'),
        expandedValue:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        category: 'General',
      ),
      Item(
        headerValue: AppLocalizations(context).of('question06'),
        expandedValue:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        category: 'Account',
      ),
      Item(
        headerValue: AppLocalizations(context).of('question07'),
        expandedValue:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        category: 'General',
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
      appBar: AppBar(
        title: Text(AppLocalizations(context).of('help_center')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: MediaQuery.of(context).size.width > 360
                  ? const EdgeInsets.symmetric(horizontal: 16.0)
                  : const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: AppLocalizations(context).of('search'),
                  prefixIcon: Icon(Icons.search, color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
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
                    unselectedLabelStyle: TextStyles(context).getTabTextStyle(),
                    tabs: [
                      Tab(text: AppLocalizations(context).of('faq')),
                      Tab(text: AppLocalizations(context).of('contact_us')),
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
    );
  }

  Widget _buildFaqList() {
    List<Item> filteredItems = _data.where((item) {
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
                  CategoryButton(
                    category: AppLocalizations(context).of("all"),
                    selectedCategory: _selectedCategory,
                    onPressed: () {
                      setState(() {
                        _selectedCategory = AppLocalizations(context).of("all");
                      });
                    },
                  ),
                  MediaQuery.of(context).size.width > 360
                      ? SizedBox(width: 8.0)
                      : SizedBox(width: 4.0),
                  CategoryButton(
                    category: AppLocalizations(context).of("general"),
                    selectedCategory: _selectedCategory,
                    onPressed: () {
                      setState(() {
                        _selectedCategory =
                            AppLocalizations(context).of("general");
                      });
                    },
                  ),
                  MediaQuery.of(context).size.width > 360
                      ? SizedBox(width: 8.0)
                      : SizedBox(width: 4.0),
                  CategoryButton(
                    category: AppLocalizations(context).of("account"),
                    selectedCategory: _selectedCategory,
                    onPressed: () {
                      setState(() {
                        _selectedCategory =
                            AppLocalizations(context).of("account");
                      });
                    },
                  ),
                  MediaQuery.of(context).size.width > 360
                      ? SizedBox(width: 8.0)
                      : SizedBox(width: 4.0),
                  CategoryButton(
                    category: AppLocalizations(context).of("notification"),
                    selectedCategory: _selectedCategory,
                    onPressed: () {
                      setState(() {
                        _selectedCategory =
                            AppLocalizations(context).of("notification");
                      });
                    },
                  ),
                ],
              ),
            ),
            MediaQuery.of(context).size.width > 360
                ? SizedBox(height: 16.0)
                : SizedBox(height: 8.0),
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
                    children: filteredItems.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                        backgroundColor: Colors.white,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Padding(
                            padding: MediaQuery.of(context).size.width > 360
                                ? const EdgeInsets.all(8.0)
                                : const EdgeInsets.all(4.0),
                            child: ListTile(
                              title: Text(item.headerValue),
                            ),
                          );
                        },
                        body: Column(
                          children: [
                            Divider(color: Colors.grey),
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
        'icon': Icons.headset,
        'contact': '123-456'
      },
      {
        'title': AppLocalizations(context).of('whats_app'),
        'icon': Icons.wechat_sharp,
        'contact': '(480) 555-0103'
      },
      {
        'title': AppLocalizations(context).of('website'),
        'icon': Icons.language,
        'contact': 'www.example.com'
      },
      {
        'title': AppLocalizations(context).of('facebook'),
        'icon': Icons.facebook,
        'contact': 'www.facebook.com'
      },
      {
        'title': AppLocalizations(context).of('twitter'),
        'icon': Icons.transfer_within_a_station_rounded,
        'contact': 'www.twitter.com'
      },
      {
        'title': AppLocalizations(context).of('instagram'),
        'icon': Icons.camera_alt,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  ExpansionTile(
                    leading: Icon(contactMethods[index]['icon'],
                        color: Colors.brown),
                    title: Text(contactMethods[index]['title']),
                    children: [
                      Divider(color: Colors.grey),
                      if (contactMethods[index]['contact'] != null)
                        ListTile(
                          title: Text(contactMethods[index]['contact']),
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.brown),
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
}

class Item {
  Item({
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
