import 'package:flutter/material.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'invite_button.dart';

class InviteFriendsScreen extends StatelessWidget {
  final List<Map<String, String>> friends = [
    {
      'name': 'Carla Schoen',
      'phone': '207.555.0119',
      'image': 'assets/images/carla.jpg'
    },
    {
      'name': 'Esther Howard',
      'phone': '702.555.0122',
      'image': 'assets/images/carla.jpg'
    },
    {
      'name': 'Robert Fox',
      'phone': '239.555.0108',
      'image': 'assets/images/carla.jpg'
    },
    {
      'name': 'Jacob Jones',
      'phone': '316.555.0116',
      'image': 'assets/images/carla.jpg'
    },
    {
      'name': 'Jacob Jones',
      'phone': '629.555.0129',
      'image': 'assets/images/carla.jpg'
    },
    {
      'name': 'Darlene Robertson',
      'phone': '629.555.0129',
      'image': 'assets/images/carla.jpg'
    },
    {
      'name': 'Ralph Edwards',
      'phone': '203.555.0106',
      'image': 'assets/images/carla.jpg'
    },
    {
      'name': 'Ronald Richards',
      'phone': '209.555.0104',
      'image': 'assets/images/carla.jpg'
    },
    {
      'name': 'Courtney Henry',
      'phone': '208.555.0141',
      'image': 'assets/images/carla.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(AppLocalizations(context).of("invite_friends")),
      ),
      body: ListView.separated(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(friends[index]['image']!),
            ),
            title: Text(friends[index]['name']!),
            subtitle: Text(friends[index]['phone']!),
            trailing: InviteButton(
              onPressed: () {},
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 16.0,
            indent: 16.0,
            endIndent: 16.0,
            thickness: 0.2,
          );
        },
      ),
    );
  }
}
