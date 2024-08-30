class GeminiModel {
  late String _apiKey;
  late String _chatModel;

  static final GeminiModel _singleton = GeminiModel._internal();

  factory GeminiModel() {
    return _singleton;
  }

  GeminiModel._internal();

  set setApiKey(String apiKey)  => _apiKey = apiKey;
  set setChatModel(String chatModel) => _chatModel = chatModel;

  String get apiKey => _apiKey;
  String get chatModel => _chatModel;
}
