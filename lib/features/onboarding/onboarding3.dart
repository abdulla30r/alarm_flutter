import 'package:alarm/features/location/location_page.dart';
import 'package:flutter/material.dart';
import 'package:alarm/features/onboarding/onboarding_page.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      imagePath: "assets/images/gif3.gif",
      title: "Relax & Unwind",
      description: "Hope to take the courage to pursue your dreams.",
      pageIndex: 2,
      onNext: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LocationPage()),
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}
