import 'package:ant_todo_list/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class Onboard3 extends StatelessWidget {
  const Onboard3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottiefiles/Animation - 1716285506002.json',
            width: context.deviceSize.width,
          ),
          const Gap(10),
          Text(
            'បង្កើននូវផលិតភាពការងាររបស់លោកអ្នក',
            style: TextStyle(
              fontSize: 20,
              color: context.colorScheme.primary,
            ),
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.only(
              right: 20, 
              left: 20
            ),
            child: Text(
              'Helps with motivation, អ្នកអាចបែងចែកគោលដៅរយៈពេលវែងរបស់អ្នកទៅជាគោលដៅរយៈពេលខ្លីដែលតូចជាង និងអាចសម្រេចបានកាន់តែច្រើន ហើយនៅពេលអ្នកគូសនីមួយៗចេញពីបញ្ជីរបស់អ្នក ទំនុកចិត្តរបស់អ្នកនឹងកើនឡើង។',
              style: TextStyle(
                fontSize: 15,
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}