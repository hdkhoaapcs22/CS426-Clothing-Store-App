import 'package:clothing_store_app/class/user_information.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:lottie/lottie.dart';
import '../../utils/localfiles.dart';
import '../../utils/themes.dart';
import '../../utils/text_styles.dart';

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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(AppLocalizations(context).of("friend_request")),
      ),
      body: StreamBuilder(
        stream:
            UserInformationService().getUserInformationStream(widget.userID),
        builder: (context, snapshot) {
          if (snapshot.hasData || snapshot.data != null) {
            UserInformation user = snapshot.data!;
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

  Widget _buildAcceptButton(BuildContext context, String userID) {
    return OutlinedButton(
      onPressed: () async {
        await UserInformationService().acceptFriendRequest(userID);
        showAlertDialog(
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
        showAlertDialog(
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

  Future<void> showAlertDialog({required String content}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.brownButtonColor,
                    ),
                    child: Text(
                      'Close',
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(color: AppTheme.backgroundColor),
                    ))
              ],
              contentPadding: const EdgeInsets.all(20.0),
              content: Text(
                content,
                style: TextStyles(context).getLabelLargeStyle(false).copyWith(
                    color: AppTheme.redErrorColor, fontWeight: FontWeight.w400),
              ),
            ));
  }
}
