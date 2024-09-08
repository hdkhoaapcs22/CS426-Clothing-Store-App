import 'package:clothing_store_app/class/user_information.dart';
import 'package:flutter/material.dart';
import "package:iconsax/iconsax.dart";
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:lottie/lottie.dart';
import '../../utils/localfiles.dart';
import '../../utils/themes.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:clothing_store_app/widgets/common_dialogs.dart';

class FriendRequestScreen extends StatefulWidget {
  final String userID;

  FriendRequestScreen({required this.userID});

  @override
  _FriendRequestScreenState createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("friend_request"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            Expanded(
              child: StreamBuilder(
                stream: UserInformationService()
                    .getUserInformationStream(widget.userID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Lottie.asset(
                          Localfiles.loading,
                          width: MediaQuery.of(context).size.width * 0.2,
                        ));
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data == false) {
                    return const Center(child: Text('User data not found'));
                  }

                  UserInformation user = snapshot.data!;

                  return FutureBuilder<bool>(
                    future: UserInformationService()
                        .isInFriendRequest(widget.userID),
                    builder: (context, isInFriendRequestSnapshot) {
                      if (isInFriendRequestSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: Lottie.asset(
                              Localfiles.loading,
                              width: MediaQuery.of(context).size.width * 0.2,
                            ));
                      }

                      if (isInFriendRequestSnapshot.hasData &&
                          isInFriendRequestSnapshot.data!) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.imageUrl),
                          ),
                          title: Text(user.name),
                          subtitle: Text(user.phone),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildAcceptButton(context, user.userId),
                              const SizedBox(width: 8),
                              _buildDenyButton(context, user.userId),
                            ],
                          ),
                        );
                      }

                      return Center(
                        child: Text(
                          AppLocalizations(context)
                              .of("we_are_friends_already"),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcceptButton(BuildContext context, String userID) {
    return OutlinedButton(
      onPressed: () async {
        await UserInformationService().acceptFriendRequest(userID);
        Dialogs(context).showAlertDialog(
            content: AppLocalizations(context).of("accept_friend_request"));
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.green),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        AppLocalizations(context).of("accept"),
        style: TextStyle(
          color: Colors.green,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDenyButton(BuildContext context, String userID) {
    return OutlinedButton(
      onPressed: () async {
        await UserInformationService().denyFriendRequest(userID);
        Dialogs(context).showAlertDialog(
          content: AppLocalizations(context).of("deny_friend_request"),
        );
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        AppLocalizations(context).of("deny"),
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
    );
  }
}
