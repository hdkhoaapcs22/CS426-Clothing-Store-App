import 'package:clothing_store_app/class/user_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:iconsax/iconsax.dart";
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/widgets/common_dialogs.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:lottie/lottie.dart';
import '../../utils/localfiles.dart';
import 'package:intl/intl.dart';
import 'package:clothing_store_app/utils/enum.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:clothing_store_app/utils/themes.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  _InviteFriendsScreenState createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  UserInformationService userInformationService = UserInformationService();

  Map<String, bool> inviteStatus = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("invite_friends"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            Expanded(
              child: StreamBuilder(
                stream: userInformationService.getListUserInformationStream(),
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
                      snapshot.data!.isEmpty) {
                    return const Center(child: Text('User data not found'));
                  }

                  List<UserInformation> friends = snapshot.data!;

                  if (friends.isEmpty) {
                    return const Center(child: Text('No friends available'));
                  }

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      ImageProvider<Object> imageProvider;
                      if (friends[index].imageUrl.isEmpty) {
                        imageProvider = const AssetImage(Localfiles.defaultAvatar)
                            as ImageProvider<Object>;
                      } else {
                        imageProvider = NetworkImage(friends[index].imageUrl)
                            as ImageProvider<Object>;
                      }

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: imageProvider,
                          backgroundColor: Colors.white,
                        ),
                        title: Text(friends[index].name),
                        subtitle: Text(friends[index].phone),
                        trailing:
                            _buildInviteButton(context, friends[index].userId),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 16.0,
                        indent: 16.0,
                        endIndent: 16.0,
                        thickness: 0.2,
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

  Widget _buildInviteButton(BuildContext context, String friendId) {
    bool isInvited = inviteStatus[friendId] ?? false;

    return OutlinedButton(
      onPressed: isInvited
          ? null
          : () async {
              await userInformationService.addFriendRequest(friendId);

              String formattedTime =
                  DateFormat('dd MMMM yyyy HH:mm:ss').format(DateTime.now());

              await userInformationService.addNotificationWithAnotherId(
                friendId,
                {
                  'type': NotificationType.friendRequest.index,
                  'title': "Friend Request",
                  'time': formattedTime,
                  'description':
                      AppLocalizations(context).of("friend_request_descript"),
                  "userId": FirebaseAuth.instance.currentUser!.uid,
                  'isRead': false,
                },
              );

              setState(() {
                inviteStatus[friendId] = true;
              });

              Dialogs(context).showAlertDialogWithPop(
                content: AppLocalizations(context).of("invite_success"),
              );
            },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isInvited ? Colors.grey : Colors.brown),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        isInvited
            ? AppLocalizations(context).of("invited")
            : AppLocalizations(context).of("invite"),
        style: TextStyle(
          color: isInvited ? Colors.grey : Colors.brown,
          fontSize: 16,
        ),
      ),
    );
  }
}
