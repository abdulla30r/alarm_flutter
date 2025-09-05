import 'package:flutter/material.dart';
import 'package:alarm/features/onboarding/onboarding_page.dart';
import 'onboarding2.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      imagePath: "assets/images/morninggif.gif",
      title: "Sync with Nature's Rythm",
      description:
          "Experience a peaceful transition into the evening with an alarm that aligns with the sunset. Your perfect reminder, always 15 minutes before sundown.",
      pageIndex: 0,
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Onboarding2()),
        );
      },
    );
  }
}
