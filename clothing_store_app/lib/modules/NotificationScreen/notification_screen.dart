import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/class/notification_info.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:lottie/lottie.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/enum.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:clothing_store_app/utils/themes.dart';

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
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("notification"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            Expanded(
              child: StreamBuilder(
                stream: UserInformationService().getUserInfomationStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.data() != null) {
                    var userData = snapshot.data!.data()!;

                    Iterable<dynamic> notificationData =
                        userData['notifications'] == null
                            ? []
                            : userData['notifications'];

                    List<Map<String, dynamic>> notificationMap =
                        List<Map<String, dynamic>>.from(notificationData);

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
                            notification.time.isAfter(
                                now.subtract(Duration(days: 7))) &&
                            notification.time.isBefore(
                                now.subtract(Duration(days: 2))))
                        .toList();

                    List<NotificationInfo> aMonthAgoNotifications = notifications
                        .where((notification) =>
                            notification.time.isAfter(
                                now.subtract(Duration(days: 30))) &&
                            notification.time.isBefore(
                                now.subtract(Duration(days: 8))))
                        .toList();

                    bool hasNotifications = todayNotifications.isNotEmpty ||
                        yesterdayNotifications.isNotEmpty ||
                        aWeekAgoNotifications.isNotEmpty ||
                        aMonthAgoNotifications.isNotEmpty;

                    return Padding(
                      padding: MediaQuery.of(context).size.width > 360
                          ? const EdgeInsets.all(16.0)
                          : const EdgeInsets.all(8.0),
                      child: hasNotifications
                          ? ListView(
                              children: [
                                if (todayNotifications.isNotEmpty)
                                  _buildSectionHeader(
                                    context: context,
                                    title: AppLocalizations(context).of("today"),
                                    onMarkAllAsRead: () =>
                                        _markAllAsRead(todayNotifications),
                                  ),
                                ...todayNotifications.map((notification) =>
                                    _buildNotificationTile(
                                        notification: notification,
                                        context: context,
                                        title: notification.title,
                                        time: _calculateTimeDifference(
                                            notification.time, now),
                                        description: notification.description,
                                        isRead: notification.isRead)),
                                if (yesterdayNotifications.isNotEmpty)
                                  _buildSectionHeader(
                                    context: context,
                                    title: AppLocalizations(context).of("yesterday"),
                                    onMarkAllAsRead: () =>
                                        _markAllAsRead(yesterdayNotifications),
                                  ),
                                ...yesterdayNotifications
                                    .map((notification) =>
                                        _buildNotificationTile(
                                          notification: notification,
                                          context: context,
                                          title: notification.title,
                                          time: _calculateTimeDifference(
                                              notification.time, now),
                                          description: notification.description,
                                          isRead: notification.isRead,
                                        )),
                                if (aWeekAgoNotifications.isNotEmpty)
                                  _buildSectionHeader(
                                      context: context,
                                      title: AppLocalizations(context).of("a_week_ago"),
                                      onMarkAllAsRead: () =>
                                          _markAllAsRead(aWeekAgoNotifications)),
                                ...aWeekAgoNotifications
                                    .map((notification) =>
                                        _buildNotificationTile(
                                          notification: notification,
                                          context: context,
                                          title: notification.title,
                                          time: _calculateTimeDifference(
                                              notification.time, now),
                                          description: notification.description,
                                          isRead: notification.isRead,
                                        )),
                                if (aMonthAgoNotifications.isNotEmpty)
                                  _buildSectionHeader(
                                      context: context,
                                      title: AppLocalizations(context).of("a_month_ago"),
                                      onMarkAllAsRead: () =>
                                          _markAllAsRead(aMonthAgoNotifications)),
                                ...aMonthAgoNotifications.map((notification) =>
                                    _buildNotificationTile(
                                        notification: notification,
                                        context: context,
                                        title: notification.title,
                                        time: _calculateTimeDifference(
                                            notification.time, now),
                                        description: notification.description,
                                        isRead: notification.isRead)),
                              ],
                            )
                          : Center(
                              child: Text(
                                "You have no notifications",
                                style: TextStyles(context).getNotificationTextStyle(),
                              ),
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
            ),
          ],
        ),
      ),
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
        padding: MediaQuery.of(context).size.width > 360
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.all(8.0),
        margin: MediaQuery.of(context).size.width > 360
            ? const EdgeInsets.symmetric(vertical: 4.0)
            : const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
            color: isRead ? Colors.white : Colors.grey[200],
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(_getIconForNotificationType(notification.type),
                  color: Colors.brown),
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
    if (notification.isRead) return;
    await UserInformationService().deleteNotification(notification.toMap());
    notification.isRead = true;
    await UserInformationService()
        .addNotificationWithPos(notification.toMap(), notification.id!);
  }

  void _markAllAsRead(List<NotificationInfo> notificationsToMark) {
    notificationsToMark.forEach((notification) {
      _markAsRead(notification);
    });
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
    if (notification.type == NotificationType.friendRequest) {
      NavigationServices(context).pushFriendRequestScreen(notification.userId!);
    }
  }

  IconData _getIconForNotificationType(NotificationType type) {
    switch (type) {
      case NotificationType.orderShipped:
        return Icons.local_shipping;
      case NotificationType.friendRequest:
        return Icons.person_add;
      case NotificationType.flashSaleAlert:
        return Icons.flash_on;
      case NotificationType.productReviewRequest:
        return Icons.rate_review;
      case NotificationType.newPaypalAdded:
        return Icons.payment;
      default:
        return Icons.notifications;
    }
  }
}
