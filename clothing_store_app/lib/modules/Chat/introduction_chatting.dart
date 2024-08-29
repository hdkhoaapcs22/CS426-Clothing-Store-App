import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/text_styles.dart';
import '../../widgets/bottom_move_top_animation.dart';
import 'chatting_screen.dart';

class IntroductionChattingInterface extends StatefulWidget {
  final AnimationController animationController;
  const IntroductionChattingInterface(
      {super.key, required this.animationController});

  @override
  State<IntroductionChattingInterface> createState() =>
      _IntroductionChattingInterfaceState();
}

class _IntroductionChattingInterfaceState
    extends State<IntroductionChattingInterface> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BottomMoveTopAnimation(
      animationController: widget.animationController,
      child: Scaffold(
        backgroundColor: Colors.grey[200], // Background color of the screen
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.height * 0.09,
                          decoration: BoxDecoration(
                            color: AppTheme.brownButtonColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Positioned(
                          top: 17,
                          left: 14,
                          child: Icon(
                            FontAwesomeIcons.robot,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Nice to see you here! By clicking the ',
                          style: TextStyles(context)
                              .getDescriptionStyle()
                              .copyWith(fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Start chat ',
                                style: TextStyles(context)
                                    .getBoldStyle()
                                    .copyWith(fontSize: 20)),
                            const TextSpan(
                              text:
                                  'button you can chat with our AI model. You can ask anything related to our products and services.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    CommonButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChattingScreen(),
                          ),
                        );
                      },
                      buttonText: "start_chat",
                      radius: 30,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
