import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/class/notification_info.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:lottie/lottie.dart';
import 'package:clothing_store_app/utils/localfiles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppLocalizations(context).of("notification"),
        ),
      ),
      body: StreamBuilder(
          stream: UserInformationService().getUserInfomationStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.data() != null) {
              var userData = snapshot.data!.data()!;
              List<Map<String, dynamic>> notificationMap =
                  List<Map<String, dynamic>>.from(userData['notifications']);

              List<NotificationInfo> notifications = notificationMap
                  .map((map) => NotificationInfo.fromMap(map))
                  .toList();

              for (int i = 0; i < notifications.length; i++) {
                notifications[i].setId = i;
              }

              List<NotificationInfo> todayNotifications = notifications
                  .where((notification) =>
                      notification.time.year == now.year &&
                      notification.time.month == now.month &&
                      notification.time.day == now.day)
                  .toList();

              List<NotificationInfo> yesterdayNotifications = notifications
                  .where((notification) =>
                      notification.time.year == now.year &&
                      notification.time.month == now.month &&
                      notification.time.day == now.day - 1)
                  .toList();

              List<NotificationInfo> aWeekAgoNotifications = notifications
                  .where((notification) =>
                      notification.time
                          .isAfter(now.subtract(Duration(days: 7))) &&
                      notification.time
                          .isBefore(now.subtract(Duration(days: 1))))
                  .toList();

              List<NotificationInfo> aMonthAgoNotifications = notifications
                  .where((notification) =>
                      notification.time
                          .isAfter(now.subtract(Duration(days: 30))) &&
                      notification.time
                          .isBefore(now.subtract(Duration(days: 7))))
                  .toList();

              return Padding(
                padding: MediaQuery.of(context).size.width > 360
                    ? const EdgeInsets.all(16.0)
                    : const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    _buildSectionHeader(
                      context: context,
                      title: AppLocalizations(context).of("today"),
                      onMarkAllAsRead: () => _markAllAsRead(todayNotifications),
                    ),
                    ...todayNotifications.map((notification) =>
                        _buildNotificationTile(
                            notification: notification,
                            context: context,
                            icon: notification.icon,
                            title: notification.title,
                            time: _calculateTimeDifference(
                                notification.time, now),
                            description: notification.description,
                            isRead: notification.isRead)),
                    _buildSectionHeader(
                      context: context,
                      title: AppLocalizations(context).of("yesterday"),
                      onMarkAllAsRead: () =>
                          _markAllAsRead(yesterdayNotifications),
                    ),
                    ...yesterdayNotifications
                        .map((notification) => _buildNotificationTile(
                              notification: notification,
                              context: context,
                              icon: notification.icon,
                              title: notification.title,
                              time: _calculateTimeDifference(
                                  notification.time, now),
                              description: notification.description,
                              isRead: notification.isRead,
                            )),
                    _buildSectionHeader(
                        context: context,
                        title: AppLocalizations(context).of("a_week_ago"),
                        onMarkAllAsRead: () =>
                            _markAllAsRead(aWeekAgoNotifications)),
                    ...aWeekAgoNotifications
                        .map((notification) => _buildNotificationTile(
                              notification: notification,
                              context: context,
                              icon: notification.icon,
                              title: notification.title,
                              time: _calculateTimeDifference(
                                  notification.time, now),
                              description: notification.description,
                              isRead: notification.isRead,
                            )),
                    _buildSectionHeader(
                        context: context,
                        title: AppLocalizations(context).of("a_month_ago"),
                        onMarkAllAsRead: () =>
                            _markAllAsRead(aMonthAgoNotifications)),
                    ...aMonthAgoNotifications.map((notification) =>
                        _buildNotificationTile(
                            notification: notification,
                            context: context,
                            icon: notification.icon,
                            title: notification.title,
                            time: _calculateTimeDifference(
                                notification.time, now),
                            description: notification.description,
                            isRead: notification.isRead)),
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
          }),
    );
  }

  Widget _buildSectionHeader({
    required BuildContext context,
    required String title,
    required VoidCallback onMarkAllAsRead,
  }) {
    return Padding(
      padding: MediaQuery.of(context).size.width > 360
          ? const EdgeInsets.symmetric(vertical: 8.0)
          : const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles(context).getNotificationTextStyle(),
          ),
          GestureDetector(
            onTap: onMarkAllAsRead,
            child: Text(
              AppLocalizations(context).of("mark_all_as_read"),
              style: TextStyles(context).getNotificationTextStyle2(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile({
    required NotificationInfo notification,
    required BuildContext context,
    required IconData icon,
    required String title,
    required String time,
    required String description,
    required bool isRead,
  }) {
    return GestureDetector(
      onTap: () {
        _markAsRead(notification);
        _handleFriendRequestNotificationTap(notification);
      },
      child: Container(
        color: isRead ? Colors.white : Colors.grey[200],
        padding: MediaQuery.of(context).size.width > 360
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.all(8.0),
        margin: MediaQuery.of(context).size.width > 360
            ? const EdgeInsets.symmetric(vertical: 4.0)
            : const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(icon, color: Colors.brown),
            ),
            MediaQuery.of(context).size.width > 360
                ? const SizedBox(width: 16.0)
                : const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyles(context).getNotificationTextStyle3(),
                      ),
                      Text(
                        time,
                        style: TextStyles(context).getNotificationTextStyle4(),
                      ),
                    ],
                  ),
                  MediaQuery.of(context).size.width > 360
                      ? const SizedBox(width: 4.0)
                      : const SizedBox(width: 2.0),
                  Text(
                    description,
                    style: TextStyles(context).getNotificationTextStyle4(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markAsRead(NotificationInfo notification) async {
    await UserInformationService().deleteNotification(notification.toMap());
    notification.isRead = true;
    await UserInformationService()
        .addNotificationWithPos(notification.toMap(), notification.id!);
  }

  void _markAllAsRead(List<NotificationInfo> notificationsToMark) {
    for (int i = 0; i < notificationsToMark.length; i++) {
      _markAsRead(notificationsToMark[i]);
    }
  }

  String _calculateTimeDifference(DateTime notificationTime, DateTime now) {
    Duration difference = now.difference(notificationTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return AppLocalizations(context).of("just_now");
    }
  }

  void _handleFriendRequestNotificationTap(NotificationInfo notification) {
    if (notification.title == "Friend Request") {
      NavigationServices(context).pushFriendRequestScreen(notification.userId!);
    }
  }
}
