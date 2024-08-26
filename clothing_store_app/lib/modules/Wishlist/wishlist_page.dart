import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, AppBar().preferredSize.height, 24, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const CommonAppBarView(iconData: Icons.arrow_back),
              Expanded(
                child: Center(
                  child: Text(
                    'My Wishlist        ',
                    style: TextStyles(context).getTitleStyle(),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
