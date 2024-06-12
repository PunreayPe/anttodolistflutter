import 'package:ant_todo_list/data/models/task.dart';
import 'package:ant_todo_list/utils/extensions.dart';
import 'package:ant_todo_list/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    super.key, 
    required this.task
  });
  final Task task;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          CircleContainer(
            color: task.category.color.withOpacity(0.3),
            child: Icon(
              task.category.icon,
            ),
          ),
          const Gap(16),
          Text(
            task.title, 
            style: style.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            task.time,style: style.titleMedium,
          ),
          const Gap(16),
          Visibility(
            visible: !task.isCompleted,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('ការងារនឹងត្រូវបញ្ចប់នៅថ្ងៃ៖ '),
                Text(task.date),
                Icon(
                  Icons.check_box, 
                  color: task.category.color,
                ),
              ],
            )
          ),
          const Gap(16),
          Divider(
            color: task.category.color,
            thickness: 1.5,
          ),
          const Gap(16),
          Text(
            task.note.isEmpty 
            ? 'មិនមានបន្ថែមសម្រាប់កិច្ចការនេះទេ!'
            : task.note
          ),
          const Gap(16),
          Visibility(
            visible: task.isCompleted,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ការងារត្រូវបានបញ្ជប់'),
                Icon(Icons.check_box, color: Colors.green,),
              ],
            )
          ),
        ],
      ),
    );
  }
}