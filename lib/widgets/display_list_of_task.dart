import 'package:ant_todo_list/providers/task/task_provider.dart';
import 'package:ant_todo_list/utils/utils.dart';
import 'package:ant_todo_list/widgets/common_container.dart';
import 'package:ant_todo_list/widgets/task_details.dart';
import 'package:ant_todo_list/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:intl/intl.dart';

import '../data/models/task.dart';

// class DisplayListOfTask extends ConsumerWidget {
//   DisplayListOfTask({
//     super.key,
//     required this.tasks,
//     this.isCompletedTask = false,
//   });

//   final List<Task> tasks;
//   final bool isCompletedTask;
//   final isLongPressProvider = StateProvider<bool>((ref) => false);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isLongPress = ref.watch(isLongPressProvider);
//     final deviceSize = context.deviceSize;
//     final height =
//         isCompletedTask ? deviceSize.height * 0.3 : deviceSize.height * 0.25;
//     final emptyTaskMessage = isCompletedTask
//         ? 'គ្មានអ្វីដែលត្រូវធ្វើរួចរាល់ទេ'
//         : 'គ្មានអ្វីដែលត្រូវធ្វើ';

//     return CommonContainer(
//       height: height,
//       child: tasks.isEmpty
//           ? Center(
//               child: Text(
//                 emptyTaskMessage,
//                 style: context.textTheme.bodyLarge,
//               ),
//             )
//           : ListView.separated(
//               shrinkWrap: true,
//               itemCount: tasks.length,
//               padding: EdgeInsets.zero,
//               itemBuilder: (ctx, index) {
//                 final task = tasks[index];
//                 return InkWell(
//                   onLongPress: () {
//                     // AppAlerts.showDeleteAlertDialog(
//                     //   context,
//                     //   ref,
//                     //   task,
//                     // );

//                     final notifier = ref.read(isLongPressProvider.notifier);
//                     notifier.state = !notifier.state;
//                   },
//                   onTap: () async {
//                     await showModalBottomSheet(
//                         context: context,
//                         builder: (ctx) {
//                           return TaskDetails(task: task);
//                         });
//                   },
//                   child: Column(
//                     children: [
//                       TaskTile(
//                         task: task,
//                         onCompleted: (value) async {
//                           await ref
//                               .read(taskProvider.notifier)
//                               .updateTask(task)
//                               .then(
//                             (value) {
//                               AppAlerts.newdisplaySnackBar(
//                                   context,
//                                   task.isCompleted
//                                       ? 'ការងារមិនទាន់រួចរាល់'
//                                       : 'ការងាររួចរាល់',
//                                   isCom: !task.isCompleted);
//                             },
//                           );
//                         },
//                       ),
//                       Visibility(
//                         visible: ref.watch(isLongPressProvider.notifier).state,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   height: 50,
//                                   child: SwipeButton.expand(
//                                     thumb: Icon(
//                                       Icons.double_arrow_rounded,
//                                       color: Colors.white,
//                                     ),
//                                     thumbPadding: EdgeInsets.all(4),
//                                     child: Text(
//                                       "អូសដើម្បីលុប ការងារ",
//                                       style: TextStyle(
//                                         color: context.colorScheme.primary,
//                                       ),
//                                     ),
//                                     activeThumbColor:
//                                         context.colorScheme.primary,
//                                     activeTrackColor: Colors.grey.shade300,
//                                     onSwipe: () {
//                                       ref
//                                           .read(taskProvider.notifier)
//                                           .deleteTask(tasks[index])
//                                           .then((_) {
//                                         AppAlerts.newdisplaySnackBar(
//                                           context,
//                                           'បានលុបការងារ',
//                                         );
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Container(
//                                 width: 50,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: context.colorScheme.primary,
//                                 ),
//                                 child: Icon(
//                                   Icons.delete,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const Divider(
//                   thickness: 1.5,
//                 );
//               },
//             ),
//     );
//   }
// }

class DisplayListOfTask extends ConsumerWidget {
  DisplayListOfTask({
    super.key,
    required this.tasks,
    required this.selectedDate,
    this.isCompletedTask = false,
  });

  final List<Task> tasks;
  final DateTime selectedDate;
  final bool isCompletedTask;

  // Track long-press state for individual tasks
  final longPressTaskProvider = StateProvider<Task?>((ref) => null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final longPressedTask = ref.watch(longPressTaskProvider);
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTask ? deviceSize.height * 0.3 : deviceSize.height * 0.25;

    final emptyTaskMessage = isCompletedTask
        ? 'គ្មានអ្វីដែលត្រូវធ្វើរួចរាល់ទេ'
        : 'គ្មានអ្វីដែលត្រូវធ្វើ';

    // Filter tasks by selected date
    final filteredTasks = tasks.where((task) {
      final taskDate = convertToDateTime(task.date);
      return _isSameDate(taskDate, selectedDate);
    }).toList();

    return CommonContainer(
      height: height,
      child: filteredTasks.isEmpty
          ? Center(
              child: Text(
                emptyTaskMessage,
                style: context.textTheme.bodyLarge,
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: filteredTasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, index) {
                final task = filteredTasks[index];

                return InkWell(
                  onLongPress: () {
                    ref.read(longPressTaskProvider.notifier).state =
                        longPressedTask == task ? null : task;
                  },
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return TaskDetails(task: task);
                      },
                    );
                  },
                  child: Column(
                    children: [
                      TaskTile(
                        task: task,
                        onCompleted: (value) async {
                          await ref
                              .read(taskProvider.notifier)
                              .updateTask(task)
                              .then(
                            (value) {
                              AppAlerts.newdisplaySnackBar(
                                context,
                                task.isCompleted
                                    ? 'ការងារមិនទាន់រួចរាល់'
                                    : 'ការងាររួចរាល់',
                                isCom: !task.isCompleted,
                              );
                            },
                          );
                        },
                      ),
                      // Show swipe button only for the long-pressed task
                      if (longPressedTask == task)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: SwipeButton.expand(
                                    thumb: const Icon(
                                      Icons.double_arrow_rounded,
                                      color: Colors.white,
                                    ),
                                    thumbPadding: const EdgeInsets.all(4),
                                    child: const Text(
                                      "អូសដើម្បីលុប ការងារ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    activeThumbColor:
                                        context.colorScheme.primary,
                                    activeTrackColor: task.category.color,
                                    onSwipe: () {
                                      ref
                                          .read(taskProvider.notifier)
                                          .deleteTask(task)
                                          .then((_) {
                                        AppAlerts.newdisplaySnackBar(
                                          context,
                                          'បានលុបការងារ',
                                        );
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context.colorScheme.primary,
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(thickness: 1.5);
              },
            ),
    );
  }

  DateTime convertToDateTime(String dateString) {
    try {
      final format = DateFormat('MM/dd/yyyy');
      return format.parse(dateString);
    } catch (e) {
      print('Invalid date format: $e');
      return DateTime.now();
    }
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

// class DisplayListOfTask extends ConsumerWidget {
//   DisplayListOfTask({
//     super.key,
//     required this.tasks,
//     required this.selectedDate,
//     this.isCompletedTask = false,
//   });

//   final List<Task> tasks;
//   final DateTime selectedDate;
//   final bool isCompletedTask;

//   // Track long-press state for individual tasks
//   final longPressTaskProvider = StateProvider<Task?>((ref) => null);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final longPressedTask = ref.watch(longPressTaskProvider);
//     final deviceSize = context.deviceSize;
//     final height =
//         isCompletedTask ? deviceSize.height * 0.3 : deviceSize.height * 0.25;

//     final emptyTaskMessage = isCompletedTask
//         ? 'គ្មានអ្វីដែលត្រូវធ្វើរួចរាល់ទេ'
//         : 'គ្មានអ្វីដែលត្រូវធ្វើ';

//     // Filter tasks by selected date
//     final filteredTasks = tasks.where((task) {
//       final taskDate = convertToDateTime(task.date);
//       return _isSameDate(taskDate, selectedDate);
//     }).toList();

//     return ListView.separated(
//       physics: NeverScrollableScrollPhysics(),
//       separatorBuilder: (
//         BuildContext context,
//         int index,
//       ) {
//         return const Divider(thickness: 1.5);
//       },
//       shrinkWrap: true,
//       itemCount: filteredTasks.length,
//       padding: EdgeInsets.zero,
//       itemBuilder: (context, index) {
//         final taskss = filteredTasks[index];
//         return _buildTask(
//           taskss.category.color,
//           taskss.title,
//           taskss.note,
//           taskss.id!,
//           taskss.date,
//         );
//       },
//     );
//   }

//   Widget _buildTask(
//       Color color, String title, String description, int id, String start) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: const Color.fromARGB(215, 255, 255, 255),
//             ),
//             child: Icon(
//               Icons.logo_dev,
//             ),
//           ),
//           Gap(15),
//           Column(
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 description,
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//           Spacer(),
//           Text(
//             "មើលលម្អិត",
//             style: TextStyle(
//               fontSize: 15,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Icon(
//             Icons.arrow_right_rounded,
//             color: Colors.white,
//             size: 40,
//           )
//         ],
//       ),
//     );
//   }

//   DateTime convertToDateTime(String dateString) {
//     try {
//       final format = DateFormat('MM/dd/yyyy');
//       return format.parse(dateString);
//     } catch (e) {
//       print('Invalid date format: $e');
//       return DateTime.now();
//     }
//   }

//   bool _isSameDate(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }
// }
