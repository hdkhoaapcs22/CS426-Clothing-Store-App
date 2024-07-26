// import 'package:clothing_store_app/languages/appLocalizations.dart';
// import 'package:clothing_store_app/modules/verification_page.dart';
// import 'package:clothing_store_app/utils/localfiles.dart';
// import 'package:clothing_store_app/utils/text_styles.dart';
// import 'package:clothing_store_app/utils/themes.dart';
// import 'package:clothing_store_app/widgets/common_button.dart';
// import 'package:clothing_store_app/widgets/common_textfield.dart';
// import 'package:flutter/material.dart';

// class NewPasswordPage extends StatefulWidget {
//   const NewPasswordPage({super.key});

//   @override
//   State<NewPasswordPage> createState() => _NewPasswordPageState();
// }

// class _NewPasswordPageState extends State<NewPasswordPage> {
//   bool isShowingPass1 = true;
//   bool isShowingPass2 = true;

//   TextEditingController newPassController = TextEditingController();
//   TextEditingController cfNewPassController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     TextStyles textStyle = TextStyles(context);
//     return Scaffold(
//       backgroundColor: AppTheme.scaffoldBackgroundColor,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               const Padding(padding: EdgeInsets.all(28)),
//               SizedBox(
//                 width: 400,
//                 child: Row(
//                   children: [
//                     Stack(
//                       children: [
//                         OutlinedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           style: OutlinedButton.styleFrom(
//                               padding: const EdgeInsets.all(0),
//                               shape: const CircleBorder(),
//                               backgroundColor: Colors.white,
//                               side: const BorderSide(color: Colors.grey)),
//                           child: const SizedBox(
//                             width: 50,
//                             height: 50,
//                           ),
//                         ),
//                         Positioned(
//                           top: 16,
//                           left: 21,
//                           child: GestureDetector(
//                             behavior: HitTestBehavior.translucent,
//                             child: IgnorePointer(
//                               child: Image.asset(
//                                 'assets/images/left_arrow.png',
//                                 width: 20,
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     const Padding(padding: EdgeInsets.all(8)),
//                     const Spacer(),
//                   ],
//                 ),
//               ),
//               const Padding(padding: EdgeInsets.all(8)),
//               Text(
//                 AppLocalizations(context).of("new password"),
//                 style:
//                     const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
//               ),
//               Text(
//                 AppLocalizations(context).of("new pass caution1"),
//                 style: textStyle.getDescriptionStyle(),
//               ),
//               Text(
//                 AppLocalizations(context).of("new pass caution2"),
//                 style: textStyle.getDescriptionStyle(),
//               ),
//               const Padding(padding: EdgeInsets.all(24)),
//               SizedBox(
//                 width: 380,
//                 child: Row(
//                   children: [
//                     Text(
//                       AppLocalizations(context).of("password"),
//                       style: textStyle.getRegularStyle(),
//                     ),
//                     const Spacer(),
//                   ],
//                 ),
//               ),
//               const Padding(padding: EdgeInsets.all(2)),
//               Stack(children: [
//                 SizedBox(
//                   width: 380,
//                   child: CommonTextField(
//                       isObscureText: isShowingPass1,
//                       textEditingController: newPassController,
//                       contentPadding: const EdgeInsets.all(14),
//                       hintTextStyle: textStyle.getDescriptionStyle(),
//                       focusColor: const Color.fromARGB(255, 112, 79, 56),
//                       hintText: '***********',
//                       textFieldPadding: const EdgeInsets.all(0)),
//                 ),
//                 Positioned(
//                   top: 10,
//                   right: 8,
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         isShowingPass1 = !isShowingPass1;
//                       });
//                     },
//                     child: Image.asset(
//                       isShowingPass1 == true
//                           ? Localfiles.hidePassIcon
//                           : Localfiles.showPassIcon,
//                       width: 40,
//                       height: 30,
//                     ),
//                   ),
//                 ),
//               ]),
//               const Padding(padding: EdgeInsets.all(12)),
//               SizedBox(
//                 width: 380,
//                 child: Row(
//                   children: [
//                     Text(
//                       AppLocalizations(context).of("confirm password"),
//                       style: textStyle.getRegularStyle(),
//                     ),
//                     const Spacer(),
//                   ],
//                 ),
//               ),
//               const Padding(padding: EdgeInsets.all(2)),
//               Stack(children: [
//                 SizedBox(
//                   width: 380,
//                   child: CommonTextField(
//                       isObscureText: isShowingPass2,
//                       textEditingController: cfNewPassController,
//                       contentPadding: const EdgeInsets.all(14),
//                       hintTextStyle: textStyle.getDescriptionStyle(),
//                       focusColor: const Color.fromARGB(255, 112, 79, 56),
//                       hintText: '***********',
//                       textFieldPadding: const EdgeInsets.all(0)),
//                 ),
//                 Positioned(
//                   top: 10,
//                   right: 8,
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         isShowingPass2 = !isShowingPass2;
//                       });
//                     },
//                     child: Image.asset(
//                       isShowingPass2 == true
//                           ? Localfiles.hidePassIcon
//                           : Localfiles.showPassIcon,
//                       width: 40,
//                       height: 30,
//                     ),
//                   ),
//                 ),
//               ]),
//               const Padding(padding: EdgeInsets.all(18)),
//               SizedBox(
//                 width: 380,
//                 child: CommonButton(
//                   buttonTextWidget: Text(
//                       AppLocalizations(context).of("create new password"),
//                       style:
//                           const TextStyle(color: Colors.white, fontSize: 20)),
//                   radius: 35,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const VerificationPage()),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
