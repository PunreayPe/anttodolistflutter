import 'package:ant_todo_list/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Onboard4 extends StatelessWidget {
  const Onboard4({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash_screen_2.png',
            width: context.deviceSize.width / 1.5,
          ),
          const Gap(10),
          Text(
            'ជួយពង្រឹងនូវភាពចងចាំរបស់លោកអ្នក',
            style: TextStyle(
              fontSize: 18,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}