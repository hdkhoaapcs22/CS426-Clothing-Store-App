import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// it helps us access and manipulate the state of the Navigator widget anywhere in app
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

List<Map<String, String>>? globalTexts;

final FirebaseFirestore firestore = FirebaseFirestore.instance;
