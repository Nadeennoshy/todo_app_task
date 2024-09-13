import 'package:flutter/material.dart';
import 'package:todo_app_task/constants.dart';
import 'package:todo_app_task/views/home_view.dart';
import 'package:todo_app_task/widgets/custom_button.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/onboarding illustartion.png'),
            const Text(
              'Simplify,Organize,and Conquer Your Day',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Take control of your tasks and achieve your goals',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomeView();
                  }));
                },
                buttonText: 'Lets Start'),
          ],
        ),
      ),
    );
  }
}
