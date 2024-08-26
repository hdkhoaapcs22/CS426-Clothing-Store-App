import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app/utils/text_styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationInfo> notifications = [
    NotificationInfo(
      icon: Icons.local_shipping,
      title: 'Order Shipped',
      time: DateTime(2024, 8, 26, 10, 39),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      isRead: false,
    ),
    NotificationInfo(
      icon: Icons.flash_on,
      title: 'Flash Sale Alert',
      time: DateTime(2024, 8, 26, 9, 30),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      isRead: false,
    ),
    NotificationInfo(
      icon: Icons.star_border,
      title: 'Product Review Request',
      time: DateTime(2024, 8, 25, 16, 0),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      isRead: false,
    ),
    NotificationInfo(
      icon: Icons.local_shipping,
      title: 'Order Shipped',
      time: DateTime(2024, 8, 25, 14, 0),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      isRead: true,
    ),
    NotificationInfo(
      icon: Icons.payment,
      title: 'New Paypal Added',
      time: DateTime(2024, 8, 24, 10, 0),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      isRead: true,
    ),
    NotificationInfo(
      icon: Icons.flash_on,
      title: 'Flash Sale Alert',
      time: DateTime(2024, 8, 20, 18, 30),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      isRead: true,
    ),
    NotificationInfo(
      icon: Icons.local_shipping,
      title: 'Order Shipped',
      time: DateTime(2024, 7, 25, 14, 0),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int nonReadCount =
        notifications.where((notification) => !notification.isRead).length;

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
            notification.time.isAfter(now.subtract(Duration(days: 7))) &&
            notification.time.isBefore(now.subtract(Duration(days: 1))))
        .toList();

    List<NotificationInfo> aMonthAgoNotifications = notifications
        .where((notification) =>
            notification.time.isAfter(now.subtract(Duration(days: 30))) &&
            notification.time.isBefore(now.subtract(Duration(days: 7))))
        .toList();

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
        actions: [
          Padding(
            padding: MediaQuery.of(context).size.width > 360
                ? const EdgeInsets.symmetric(horizontal: 16.0)
                : const EdgeInsets.symmetric(horizontal: 8.0),
            child: Chip(
              label: Text(
                '$nonReadCount ' + AppLocalizations(context).of("new"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.brown,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: MediaQuery.of(context).size.width > 360
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SectionHeader(
              title: AppLocalizations(context).of("today"),
              onMarkAllAsRead: () => _markAllAsRead(todayNotifications),
            ),
            ...todayNotifications.map((notification) => NotificationTile(
                  icon: notification.icon,
                  title: notification.title,
                  time: _calculateTimeDifference(notification.time, now),
                  description: notification.description,
                  isRead: notification.isRead,
                  onTap: () => _markAsRead(notification),
                )),
            SectionHeader(
              title: AppLocalizations(context).of("yesterday"),
              onMarkAllAsRead: () => _markAllAsRead(yesterdayNotifications),
            ),
            ...yesterdayNotifications.map((notification) => NotificationTile(
                  icon: notification.icon,
                  title: notification.title,
                  time: _calculateTimeDifference(notification.time, now),
                  description: notification.description,
                  isRead: notification.isRead,
                  onTap: () => _markAsRead(notification),
                )),
            SectionHeader(
              title: AppLocalizations(context).of("a_week_ago"),
              onMarkAllAsRead: () => _markAllAsRead(aWeekAgoNotifications),
            ),
            ...aWeekAgoNotifications.map((notification) => NotificationTile(
                  icon: notification.icon,
                  title: notification.title,
                  time: _calculateTimeDifference(notification.time, now),
                  description: notification.description,
                  isRead: notification.isRead,
                  onTap: () => _markAsRead(notification),
                )),
            SectionHeader(
              title: AppLocalizations(context).of("a_month_ago"),
              onMarkAllAsRead: () => _markAllAsRead(aMonthAgoNotifications),
            ),
            ...aMonthAgoNotifications.map((notification) => NotificationTile(
                  icon: notification.icon,
                  title: notification.title,
                  time: _calculateTimeDifference(notification.time, now),
                  description: notification.description,
                  isRead: notification.isRead,
                  onTap: () => _markAsRead(notification),
                )),
          ],
        ),
      ),
    );
  }

  void _markAsRead(NotificationInfo notification) {
    setState(() {
      notification.isRead = true;
    });
  }

  void _markAllAsRead(List<NotificationInfo> notificationsToMark) {
    setState(() {
      notificationsToMark.forEach((notification) {
        notification.isRead = true;
      });
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
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onMarkAllAsRead;

  SectionHeader({required this.title, required this.onMarkAllAsRead});

  @override
  Widget build(BuildContext context) {
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
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final String description;
  final bool isRead;
  final VoidCallback onTap;

  NotificationTile({
    required this.icon,
    required this.title,
    required this.time,
    required this.description,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
}

class NotificationInfo {
  final IconData icon;
  final String title;
  final DateTime time;
  final String description;
  bool isRead;

  NotificationInfo({
    required this.icon,
    required this.title,
    required this.time,
    required this.description,
    required this.isRead,
  });
}
