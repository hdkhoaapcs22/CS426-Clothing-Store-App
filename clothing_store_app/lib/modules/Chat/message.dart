import 'package:clothing_store_app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final bool isFromUser;

  const MessageWidget({
    super.key,
    required this.message,
    required this.isFromUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: isFromUser ? AppTheme.brownButtonColor : Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 12.0,
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.isNotEmpty)
                    MarkdownBody(
                      data: message,
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(
                          color: isFromUser ? Colors.white : Colors.black,
                           fontSize: 16.0, 
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
