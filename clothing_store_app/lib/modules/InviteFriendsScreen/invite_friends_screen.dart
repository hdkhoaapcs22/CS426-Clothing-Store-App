import 'package:clothing_store_app/class/user_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/widgets/common_dialogs.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:lottie/lottie.dart';
import '../../utils/localfiles.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({Key? key}) : super(key: key);

  @override
  _InviteFriendsScreenState createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  UserInformationService userInformationService = UserInformationService();

  Map<String, bool> inviteStatus = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(AppLocalizations(context).of("invite_friends")),
      ),
      body: StreamBuilder(
        stream: userInformationService.getListUserInformationStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData || snapshot.data!.isNotEmpty) {
            List<UserInformation> friends = snapshot.data!;

            if (friends.isEmpty) {
              return Center(child: Text('No friends available'));
            }

            return ListView.separated(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(friends[index].imageUrl),
                  ),
                  title: Text(friends[index].name),
                  subtitle: Text(friends[index].phone),
                  trailing: _buildInviteButton(context, friends[index].userId),
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
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Lottie.asset(
                Localfiles.loading,
                width: MediaQuery.of(context).size.width * 0.2,
              ));
        },
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

              await userInformationService.addNotificationWithAnotherId(
                friendId,
                {
                  'icon': Icons.people_alt.codePoint,
                  'title': "Friend Request",
                  'time': DateTime.now().millisecondsSinceEpoch,
                  'description':
                      AppLocalizations(context).of("friend_request_descript"),
                  "userId": FirebaseAuth.instance.currentUser!.uid,
                  'isRead': false,
                },
              );

              setState(() {
                inviteStatus[friendId] = true;
              });

              Dialogs(context).showAlertDialog(
                content: AppLocalizations(context).of("invite_success"),
              );
            },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isInvited ? Colors.grey : Colors.brown),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
