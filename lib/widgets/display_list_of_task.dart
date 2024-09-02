import 'package:ant_todo_list/providers/providers.dart';
import 'package:ant_todo_list/utils/utils.dart';
import 'package:ant_todo_list/widgets/task_details.dart';
import 'package:ant_todo_list/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/task.dart';
import 'common_container.dart';

class DisplayListOfTask extends ConsumerWidget {
  const DisplayListOfTask({
    super.key,
    required this.tasks,
    this.isCompletedTask = false,
  });

  final List<Task> tasks;
  final bool isCompletedTask;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTask ? deviceSize.height * 0.3 : deviceSize.height * 0.25;
    final emptyTaskMessage = isCompletedTask
        ? 'គ្មានអ្វីដែលត្រូវធ្វើរួចរាល់ទេ'
        : 'គ្មានអ្វីដែលត្រូវធ្វើ';

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTaskMessage,
                style: context.textTheme.bodyLarge,
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: tasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, index) {
                final task = tasks[index];
                return InkWell(
                  onLongPress: () {
                    AppAlerts.showDeleteAlertDialog(
                      context,
                      ref,
                      task,
                    );
                  },
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (ctx) {
                          return TaskDetails(task: task);
                        });
                  },
                  child: TaskTile(
                    task: task,
                    onCompleted: (value) async {
                      await ref
                          .read(taskProvider.notifier)
                          .updateTask(task)
                          .then((value) {
                        AppAlerts.displaySnackBar(
                            context,
                            task.isCompleted
                                ? 'ការងារមិនទាន់រួចរាល់'
                                : 'ការងាររួចរាល់');
                      });
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1.5,
                );
              },
            ),
    );
  }
}
