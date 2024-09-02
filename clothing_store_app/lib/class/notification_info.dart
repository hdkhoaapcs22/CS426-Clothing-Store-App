import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

IconData getIconDataFromCodepoint(int codepoint,
    {String fontFamily = 'MaterialIcons', String? fontPackage}) {
  return IconData(
    codepoint,
    fontFamily: fontFamily,
    fontPackage: fontPackage,
  );
}

class NotificationInfo {
  int? id;
  final IconData icon;
  final String title;
  final DateTime time;
  final String description;
  final String? userId; // for friend request
  bool isRead;

  NotificationInfo({
    this.id,
    required this.icon,
    required this.title,
    required this.time,
    required this.description,
    required this.isRead,
    this.userId,
  });

  set setId(int id) {
    this.id = id;
  }

  factory NotificationInfo.fromMap(Map<String, dynamic> map) {
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy HH:mm');
    final DateTime parsedDate = dateFormat.parse(map['time']);

    IconData icon = getIconDataFromCodepoint(map['icon']);

    return NotificationInfo(
      icon: icon,
      title: map['title'],
      time: parsedDate,
      description: map['description'],
      userId: map['userId'], // for friend request
      isRead: map['isRead'],
    );
  }

  Map<String, dynamic> toMap() {
    String timeString = DateFormat('dd MMMM yyyy HH:mm').format(time);
    return {
      'icon': icon.codePoint,
      'title': title,
      'time': timeString,
      'description': description,
      'userId': userId, // for friend request
      'isRead': isRead,
    };
  }
}
