import 'package:flutter/material.dart';
import 'package:alarm/features/onboarding/onboarding_page.dart';
import 'onboarding3.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      imagePath: "assets/images/secondgif.gif",
      title: "Effortless & Automatic",
      description:
          "No need to set alarms manually. Wakey calculates the sunset time for your location and alerts you on time.",
      pageIndex: 1,
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Onboarding3()),
        );
      },
    );
  }
}
