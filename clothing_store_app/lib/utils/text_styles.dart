import 'package:clothing_store_app/utils/enum.dart';
import 'package:flutter/material.dart';
import 'themes.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  TextStyle getTitleStyle([double size = 24]) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: size,
          color: AppTheme.primaryTextColor,
        );
  }

  TextStyle getDescriptionStyle() {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppTheme.secondaryTextColor,
            ));
  }

  TextStyle getRegularStyle() {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16,
          color: AppTheme.primaryTextColor,
        );
  }

  TextStyle getBoldStyle() {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 14,
          color: AppTheme.primaryTextColor,
        );
  }

  TextStyle getSmallStyle() {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: AppTheme.primaryTextColor,
        );
  }

  TextStyle getSplashScreenStyle(bool isIcon, bool isDot) {
    return AppTheme.getTextStyle(
        FontFamilyType.DmSerifDisplay,
        Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: isIcon
                ? const Color(0xFFFFFFFF)
                : (isDot ? AppTheme.brownColor : AppTheme.fontcolor)));
  }

  TextStyle getHeaderStyle(bool isBrown) {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: isBrown ? AppTheme.brownColor : AppTheme.fontcolor,
              fontWeight: FontWeight.bold,
            ));
  }

  TextStyle getLargerHeaderStyle(bool isBrown) {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: isBrown ? AppTheme.brownColor : AppTheme.fontcolor,
              fontWeight: FontWeight.bold,
            ));
  }

  TextStyle getInterDescriptionStyle(bool isBrown, bool isUnderlined) {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: isBrown ? AppTheme.brownColor : AppTheme.secondaryTextColor,
            fontWeight: FontWeight.w500,
            decoration: isUnderlined ? TextDecoration.underline : null,
            decorationColor:
                isBrown ? AppTheme.brownColor : AppTheme.secondaryTextColor));
  }

  TextStyle getLabelLargeStyle(bool isGrey) {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.labelLarge!.copyWith(
              color: isGrey
                  ? AppTheme.secondaryTextColor
                  : AppTheme.primaryTextColor,
              fontWeight: FontWeight.w500,
            ));
  }

  TextStyle getButtonTextStyle() {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ));
  }

  TextStyle getNotificationTextStyle() {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ));
  }

  TextStyle getNotificationTextStyle2() {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppTheme.brownColor,
              fontWeight: FontWeight.normal,
            ));
  }

  TextStyle getNotificationTextStyle3() {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ));
  }

  TextStyle getNotificationTextStyle4() {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ));
  }

  TextStyle getPrivacyPolicyTextStyle() {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 18,
              color: AppTheme.brownColor,
              fontWeight: FontWeight.bold,
            ));
  }

  TextStyle getPrivacyPolicyTextStyle2() {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 16,
              color: AppTheme.primaryTextColor,
              fontWeight: FontWeight.normal,
            ));
  }

  TextStyle getTabTextStyle() {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ));
  }

  TextStyle getCategoryButtonStyle(bool isSelected) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black,
        );
  }

  TextStyle getTextFieldHintStyle() {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: AppTheme.secondaryTextColor,
        );
  }

  TextStyle getFAQHeaderStyle() {
    return AppTheme.getTextStyle(
        FontFamilyType.Inter,
        Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: AppTheme.primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ));
  }
  TextStyle getSubtitleStyle() {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          color: AppTheme.secondaryTextColor,
        );
  }
}
