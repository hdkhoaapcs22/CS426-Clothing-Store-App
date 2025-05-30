import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/widgets/common_dialogs.dart';
import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        model: dotenv.env['chat_model']!, apiKey: dotenv.env['key']!);
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
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
          _buildBottomInputField(context),
        ],
      ),
    );
  }

  Widget _buildBottomInputField(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: MediaQuery.of(context).size.height * 0.015),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.065,
                child: Form(
                    key: _formKey,
                    child: CommonTextField(
                      textEditingController: _textController,
                      hintText:
                          AppLocalizations(context).of("enter_your_prompt"),
                      focusColor: const Color.fromARGB(255, 112, 79, 56),
                      cursorColor: const Color.fromARGB(255, 112, 79, 56),
                      textFieldPadding: EdgeInsets.zero,
                      isObscureText: false,
                      keyboardType: TextInputType.text,
                      hintTextStyle: TextStyles(context).getDescriptionStyle(),
                    )),
              ),
            ),
            const SizedBox(width: 8.0),
            if (!_isLoading) ...[
              Expanded(
                child: CommonButton(
                    onTap: () {
                      _sendChatMessage(_textController.text);
                    },
                    radius: 30,
                    height: MediaQuery.of(context).size.height * 0.06,
                    buttonText: "send"),
              ),
            ] else ...[
              const CircularProgressIndicator.adaptive(),
            ]
          ],
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
