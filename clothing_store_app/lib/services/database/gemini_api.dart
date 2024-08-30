import 'package:clothing_store_app/services/database/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../class/gemini.dart';

class GeminiApiService extends ApiService {
  static final GeminiApiService _singleton = GeminiApiService._internal();

  factory GeminiApiService() {
    _singleton.getInformationOfGemini();
    return _singleton;
  }

  GeminiApiService._internal();

  Future<void> getInformationOfGemini() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await collection.doc('gemini_chatting').get();
    final Map<String, dynamic> data = documentSnapshot.data()!;
    GeminiModel().setApiKey = data['key'];
    GeminiModel().setChatModel = data['chat_model'];
  }
}
