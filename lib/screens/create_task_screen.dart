import 'package:ant_todo_list/data/data.dart';
import 'package:ant_todo_list/providers/providers.dart';
import 'package:ant_todo_list/utils/utils.dart';
import 'package:ant_todo_list/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
    const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  
  TaskDataSource task = TaskDataSource(); // not yet test 
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }
  
  // not yet test
  void init() {
    task.getAllTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('បន្ថែមការងារថ្មី'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                title: 'ឈ្មោះការងារ',
                hintText: 'ឈ្មោះការងាររបស់អ្នក',
                controller: _titleController,
              ),
              const Gap(10),
              const SelectCategory(),
              const SeleteDateTime(),
              const Gap(10),
              CommonTextField(
                title: 'លម្អិត',
                hintText: 'ពិពណ៌នាការងាររបស់អ្នក',
                controller: _noteController,
                maxLines: 6,
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: createTask,
                child: const Text(
                'រក្សាទុក',
                  style: TextStyle(
                    fontSize: 20,
                  ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);
    if(title.isNotEmpty){
      final task = Task(
        title: title,
        note: note,
        time: Helpers.timeToString(time),
        date: DateFormat.yMMMMd().format(date),
        category: category,
        isCompleted: false,
      );

      await ref.read(taskProvider.notifier).createTask(task).then((value){
        AppAlerts.displaySnackBar(context, 'ការងារត្រូវបានបង្កើតឡើង');
          Navigator.pop(context);
      });
    } else{
      AppAlerts.displaySnackBar(context, 'មិនមានទិន្នន័យក្នុងការបង្កើតការងារ');
    }
  }
}