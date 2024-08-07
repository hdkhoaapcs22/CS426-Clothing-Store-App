// import 'package:clothing_store_app/utils/text_styles.dart';
// import 'package:clothing_store_app/utils/themes.dart';
// import 'package:clothing_store_app/widgets/common_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class VerificationPage extends StatefulWidget {
//   const VerificationPage({super.key});

//   @override
//   State<VerificationPage> createState() => _VerificationPageState();
// }

// class _VerificationPageState extends State<VerificationPage> {
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
//               const Text(
//                 'Verify Code',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
//               ),
//               Text(
//                 'Please enter the code we just sent to email',
//                 style: textStyle.getDescriptionStyle(),
//               ),
//               const Text(
//                 'example@gmail.com',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 112, 79, 56),
//                     fontWeight: FontWeight.bold),
//               ),
//               const Padding(padding: EdgeInsets.all(20)),
//               SizedBox(
//                 width: 380,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: 80,
//                       height: 60,
//                       child: TextFormField(
//                         cursorColor: const Color.fromARGB(255, 114, 114, 114),
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(30)),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromARGB(255, 112, 79, 56)),
//                               borderRadius: BorderRadius.circular(30)),
//                           hintText: '-',
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(1),
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         onChanged: (value) {
//                           if (value.length == 1) {
//                             FocusScope.of(context).nextFocus();
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 80,
//                       height: 60,
//                       child: TextFormField(
//                         cursorColor: const Color.fromARGB(255, 114, 114, 114),
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(30)),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromARGB(255, 112, 79, 56)),
//                               borderRadius: BorderRadius.circular(30)),
//                           hintText: '-',
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(1),
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         onChanged: (value) {
//                           if (value.length == 1) {
//                             FocusScope.of(context).nextFocus();
//                           }
//                           if (value.isEmpty) {
//                             FocusScope.of(context).previousFocus();
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 80,
//                       height: 60,
//                       child: TextFormField(
//                         cursorColor: const Color.fromARGB(255, 114, 114, 114),
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(30)),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromARGB(255, 112, 79, 56)),
//                               borderRadius: BorderRadius.circular(30)),
//                           hintText: '-',
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(1),
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         onChanged: (value) {
//                           if (value.length == 1) {
//                             FocusScope.of(context).nextFocus();
//                           }
//                           if (value.isEmpty) {
//                             FocusScope.of(context).previousFocus();
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 80,
//                       height: 60,
//                       child: TextFormField(
//                         cursorColor: const Color.fromARGB(255, 114, 114, 114),
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(30)),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromARGB(255, 112, 79, 56)),
//                               borderRadius: BorderRadius.circular(30)),
//                           hintText: '-',
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(1),
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         onChanged: (value) {
//                           if (value.isEmpty) {
//                             FocusScope.of(context).previousFocus();
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Padding(padding: EdgeInsets.all(20)),
//               Text(
//                 'Didn\'t receive OTP?',
//                 style: textStyle.getDescriptionStyle(),
//               ),
//               const Text(
//                 'Resend code',
//                 style: TextStyle(
//                     decoration: TextDecoration.underline,
//                     color: Color.fromARGB(255, 112, 79, 56),
//                     fontWeight: FontWeight.bold),
//               ),
//               const Padding(padding: EdgeInsets.all(16)),
//               SizedBox(
//                 width: 380,
//                 child: CommonButton(
//                   buttonTextWidget: const Text('Verify',
//                       style: TextStyle(color: Colors.white, fontSize: 20)),
//                   radius: 35,
//                   onTap: () {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
