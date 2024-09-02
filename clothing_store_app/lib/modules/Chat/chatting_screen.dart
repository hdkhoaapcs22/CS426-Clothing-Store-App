import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/widgets/common_dialogs.dart';
import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../class/gemini.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_button.dart';
import 'message.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final GenerativeModel _model;
  late final ScrollController _scrollController;
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late ChatSession _chatSession;
  late bool _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = GenerativeModel(
        model: GeminiModel().chatModel, apiKey: GeminiModel().apiKey);
    _scrollController = ScrollController();
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _chatSession = _model.startChat();
    _isLoading = false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations(context).of("chat_with_ai")),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _chatSession.history.length,
          itemBuilder: (context, index) {
            var content = _chatSession.history.toList()[index];
            final message = _getMessageFromContent(content);
            return MessageWidget(
              isFromUser: content.role == 'user',
              message: message,
            );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey[200]!),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Form(
                      key: _formKey,
                      child: CommonTextField(
                        textEditingController: _textController,
                        contentPadding: const EdgeInsets.all(8.0),
                        hintText:
                            AppLocalizations(context).of("enter_your_prompt"),
                        focusColor: const Color.fromARGB(255, 112, 79, 56),
                        textFieldPadding: const EdgeInsets.all(8.0),
                        isObscureText: false,
                        keyboardType: TextInputType.text,
                        hintTextStyle:
                            TextStyles(context).getDescriptionStyle(),
                      )),
                ),
                const SizedBox(width: 8.0),
                if (!_isLoading) ...[
                  Expanded(
                    child: CommonButton(
                        onTap: () {
                          _sendChatMessage(_textController.text);
                        },
                        radius: 30,
                        height: 50,
                        buttonText: "send"),
                  ),
                ] else ...[
                  const CircularProgressIndicator.adaptive(),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getMessageFromContent(Content content) {
    return content.parts.whereType<TextPart>().map((e) => e.text).join('');
  }

  void _sendChatMessage(String message) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _setLoading(true);
    try {
      var response = await _chatSession.sendMessage(Content.text(message));

      final text = response.text;
      if (text == null) {
        Dialogs(context).showErrorDialog(message: 'No response was found');
      }
    } catch (e) {
      Dialogs(context).showErrorDialog(message: e.toString());
    } finally {
      _textController.clear();
      _focusNode.requestFocus();
      _setLoading(false);
    }
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }
}
