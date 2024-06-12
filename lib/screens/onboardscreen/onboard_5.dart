import 'package:ant_todo_list/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class Onboard5 extends StatelessWidget {
  const Onboard5({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottiefiles/Animation - 1716970576918.json',
            width: context.deviceSize.width,
          ),
          const Gap(10),
          Text(
            'តោះចាប់ផ្តើម',
            style: TextStyle(
              fontSize: 25,
              color: context.colorScheme.primary,
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}