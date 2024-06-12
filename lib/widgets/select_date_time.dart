import 'package:ant_todo_list/providers/providers.dart';
import 'package:ant_todo_list/utils/utils.dart';
import 'package:ant_todo_list/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SeleteDateTime extends ConsumerWidget {
  const SeleteDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            readOnly: true,
            title: 'ថ្ងៃ',
            hintText: DateFormat.yMMMMd().format(date),
            suffixIcon: IconButton(
              onPressed: () => Helpers.selectDate(context, ref), 
              icon: const FaIcon(FontAwesomeIcons.calendar),
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          child: CommonTextField(
            readOnly: true,
            title: 'ម៉ោង',
            hintText: Helpers.timeToString(time),
            suffixIcon: IconButton(
              onPressed: () => _selectTime(context, ref), 
              icon: const FaIcon(FontAwesomeIcons.clock),
            ),
          ),
        ),
      ],
    );
  }
  void _selectTime(BuildContext context, WidgetRef ref) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
    );
    if(pickedTime != null){
      ref.read(timeProvider.notifier).state = pickedTime; 
    }
  }
  
}