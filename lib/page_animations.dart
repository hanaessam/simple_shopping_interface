import 'package:flutter/material.dart';
import 'package:simple_shopping_interface/shopping_page.dart';
import 'package:simple_shopping_interface/sign_up_page.dart';

// widget to cntrol the page animation
class PageAnimation extends StatefulWidget {
  const PageAnimation({super.key});

  @override
  State<PageAnimation> createState() => _PageAnimationState();
}

class _PageAnimationState extends State<PageAnimation> {
  // flag to show sign up page
  bool showSignUp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // sign up page fades out
          AnimatedOpacity(
            opacity: showSignUp ? 1.0 : 0.0,
            duration: const Duration(seconds: 5),
            child: showSignUp
                ? SignUpPage(onSignUpComplete: () {
                    setState(() {
                      showSignUp = false;
                    });
                  })
                : Container(),
          ),

          // shopping page fades in
          AnimatedOpacity(
            opacity: showSignUp ? 0.0 : 1.0,
            duration: const Duration(seconds: 1),
            child:
                showSignUp ? Container() : ShoppingPage(title: 'Shopping Page'),
          ),
        ],
      ),
    );
  }
}
