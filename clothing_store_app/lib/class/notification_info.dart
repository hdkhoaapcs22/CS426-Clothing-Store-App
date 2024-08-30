import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationInfo {
  int? id;
  final IconData icon;
  final String title;
  final DateTime time;
  final String description;
  bool isRead;

  NotificationInfo({
    this.id,
    required this.icon,
    required this.title,
    required this.time,
    required this.description,
    required this.isRead,
  });

  set setId(int id) {
    this.id = id;
  }

  factory NotificationInfo.fromMap(Map<String, dynamic> map) {
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy HH:mm');
    final DateTime parsedDate = dateFormat.parse(map['time']);

    return NotificationInfo(
      icon: IconData(map['icon']),
      title: map['title'],
      time: parsedDate,
      description: map['description'],
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
      'isRead': isRead,
    };
  }
}
