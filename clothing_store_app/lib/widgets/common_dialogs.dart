import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/text_styles.dart';
import '../utils/themes.dart';

class Dialogs {
  final BuildContext context;
  Dialogs(this.context);

  static Future<dynamic> showLoadingDialog(BuildContext context) async {
    return await showDialog(
      context: context, 
      builder: (context) => Center(
        child: Container(
          child: Lottie.asset('assets/json/let_start_lottie.json'),
        ),
      )
    );
  }

  Future<void> showAlertDialog(
    {required String content}) async {
    return showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        actions: [
          ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.brownButtonColor,
                      ),
                      child: Text(
                        'Close',
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(color: AppTheme.backgroundColor),
                      ))
                ],
                contentPadding: const EdgeInsets.all(20.0),
                content: Text(content, style: TextStyles(context).getLabelLargeStyle(false).copyWith(color: AppTheme.redErrorColor, fontWeight: FontWeight.w400),),
      )
    );
  }

  Future<void> showAnimatedDialog({required String title, required String content}){
    return showGeneralDialog(
      context: context, 
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (content, animation1, animation2){
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget){
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialog(
              title: Text(title, style: TextStyles(context).getButtonTextStyle().copyWith(
                color: AppTheme.primaryTextColor
              ),),
              content:  Text(content, style: TextStyles(context).getLabelLargeStyle(false).copyWith(color: AppTheme.redErrorColor, fontWeight: FontWeight.w400),),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none
              ),
            ),
          ),
        );
      }
    );
  }
}