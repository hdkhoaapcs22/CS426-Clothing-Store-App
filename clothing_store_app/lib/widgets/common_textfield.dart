import 'package:flutter/material.dart';

import '../utils/text_styles.dart';
import '../utils/themes.dart';

// ignore: must_be_immutable
class CommonTextFieldView extends StatefulWidget {
  final IconData? prefixIconData, suffixIconData, selectedIconData;
  final Color? initialIconColor;
  final TextInputType? keyboardType;
  final String? errorText;
  final TextStyle hintTextStyle;
  final void Function(String) onSubmitted;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry textFieldPadding;
  final Color focusColor;
  final String hintText;
  bool isObscureText;

  CommonTextFieldView({
    super.key,
    required this.onSubmitted,
    required this.contentPadding,
    required this.hintTextStyle,
    required this.focusColor,
    required this.hintText,
    required this.textFieldPadding,
    this.initialIconColor,
    this.keyboardType,
    this.selectedIconData,
    this.errorText,
    this.suffixIconData,
    this.prefixIconData,
    this.isObscureText = false,
  });

  @override
  State<CommonTextFieldView> createState() => _CommonTextFieldViewState();
}

class _CommonTextFieldViewState extends State<CommonTextFieldView> {
  late final FocusNode _focusNode;
  late Color _iconColor;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _iconColor = widget.initialIconColor ?? Colors.grey;
    if (widget.isObscureText) _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _iconColor = _focusNode.hasFocus ? widget.focusColor : Colors.grey;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.textFieldPadding,
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.left,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.isObscureText,
            autocorrect: false,
            onFieldSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
              prefixIcon: widget.prefixIconData != null
                  ? Icon(widget.prefixIconData, color: _iconColor)
                  : null,
              suffixIcon: widget.suffixIconData != null
                  ? IconButton(
                      isSelected: !widget.isObscureText,
                      icon: Icon(widget.suffixIconData, color: _iconColor),
                      selectedIcon:
                          Icon(widget.selectedIconData, color: _iconColor),
                      onPressed: () => setState(() {
                        widget.isObscureText = !widget.isObscureText;
                      }),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(
                  color: widget.focusColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(
                  color: widget.focusColor,
                ),
              ),
            ),
          ),
          if (widget.errorText != null && widget.errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                widget.errorText ?? "",
                style: TextStyles(context).getDescriptionStyle().copyWith(
                      color: AppTheme.redErrorColor,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
