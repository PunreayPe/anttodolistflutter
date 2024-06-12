import 'package:ant_todo_list/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class Onboard2 extends StatelessWidget {
  const Onboard2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottiefiles/Animation - 1716285359094.json',
            width: context.deviceSize.width,
          ),
          Text(
            'ជាកម្មវិធីដែលបង្កើតឡើងដើម្បី',
            style: TextStyle(
              fontSize: 22,
              color: context.colorScheme.primary,
            ),
          ),
          const Gap(10),
          Text(
            'បង្កើននូវផលិតភាពការងាររបស់លោកអ្នក',
            style: TextStyle(
              fontSize: 15,
              color: context.colorScheme.primary,
            ),
          ),
          const Gap(10),
          Text(
            'និង ដើម្បីដោះស្រាយពីបញ្ហានៃការចងចាំរបស់លោកអ្នក',
            style: TextStyle(
              fontSize: 15,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}