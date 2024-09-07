import 'package:intl/intl.dart';
import 'package:clothing_store_app/utils/enum.dart';

class NotificationInfo {
  int? id;
  final String title;
  final DateTime time;
  final String description;
  final String? userId; // for friend request
  bool isRead;
  NotificationType type;

  NotificationInfo({
    this.id,
    required this.title,
    required this.time,
    required this.description,
    required this.isRead,
    required this.type,
    this.userId,
  });

  set setId(int id) {
    this.id = id;
  }

  factory NotificationInfo.fromMap(Map<String, dynamic> map) {
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy HH:mm:ss');
    final DateTime parsedDate = dateFormat.parse(map['time']);

    return NotificationInfo(
      title: map['title'],
      time: parsedDate,
      description: map['description'],
      userId: map['userId'], // for friend request
      isRead: map['isRead'],
      type: NotificationType.values[map['type']], // type saved in number
    );
  }

  Map<String, dynamic> toMap() {
    String timeString = DateFormat('dd MMMM yyyy HH:mm:ss').format(time);
    return {
      'title': title,
      'time': timeString,
      'description': description,
      'userId': userId, // for friend request
      'isRead': isRead,
      'type': type.index,
    };
  }
}
