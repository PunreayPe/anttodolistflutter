import 'package:ant_todo_list/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class Onboard1 extends StatelessWidget {
  const Onboard1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottiefiles/Animation - 1716969860599.json',
            width: context.deviceSize.width,
          ),
          Text(
            'ងាយស្រួលក្នុងការកត់ត្រាពីការងាររបស់អ្នក',
            style: TextStyle(
              fontSize: 20,
              color: context.colorScheme.primary,
            ),
          ),
          const Gap(10),
          Text(
            'ចំណេញពេលវេលា, ងាយស្រួលចាំពីការងាររបស់អ្នក',
            style: TextStyle(
              fontSize: 15,
              color: context.colorScheme.primary,
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
