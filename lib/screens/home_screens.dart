import 'package:ant_todo_list/config/theme/theme_notifier.dart';
import 'package:ant_todo_list/data/datasource/task_datasource.dart';
import 'package:ant_todo_list/data/models/task.dart';
import 'package:ant_todo_list/providers/providers.dart';
import 'package:ant_todo_list/screens/abtdev.dart';
import 'package:ant_todo_list/screens/create_task_screen.dart';
import 'package:ant_todo_list/screens/settingscreen.dart';
import 'package:ant_todo_list/utils/utils.dart';
import 'package:ant_todo_list/widgets/widgets.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://antkh.com/');

class Homescreens extends ConsumerWidget {
  static Homescreens builder(BuildContext context, GoRouterState state) =>
      const Homescreens();

  const Homescreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TaskDataSource task = TaskDataSource();
    task.getAllTask();
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    final completeTask = _completedTask(taskState.tasks, ref);
    final incompleteTask = _incompletedTask(taskState.tasks, ref);
    final selectDate = ref.watch(dateProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('អានធូឌូលីស'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutDeveloper(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context, ref),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: colors.primary,
                child: Column(
                  children: [
                    const Gap(10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: deviceSize.height * 0.12,
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DatePicker(
                        DateTime.now(),
                        width: 72,
                        selectionColor: colors.primary,
                        initialSelectedDate: selectDate,
                        selectedTextColor: colors.surfaceContainerLowest,
                        onDateChange: (selectedDate) {
                          ref.read(dateProvider.notifier).state = selectedDate;
                        },
                        daysCount: 7,
                      ),
                    ),
                    const Gap(10),
                    const DisplayWhiteText(
                      text: 'ការងារដែលមិនទាន់រួចរាល់',
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListOfTask(
                      tasks: incompleteTask,
                    ),
                    const Gap(10),
                    Text(
                      'ការងារបានធ្វើរួចរាល់',
                      style: context.textTheme.headlineSmall,
                    ),
                    const Gap(10),
                    DisplayListOfTask(
                      tasks: completeTask,
                      isCompletedTask: true,
                    ),
                    const Gap(10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateTaskScreen(),
                          ),
                        );
                      },
                      child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            'បន្ថែមការងារថ្មី',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Task> _completedTask(List<Task> tasks, WidgetRef ref) {
    final selectedDate = ref.watch(dateProvider);

    final List<Task> filteredTask = [];
    for (var task in tasks) {
      final isTaskDay = Helpers.isTaskFromSelectDate(task, selectedDate);
      if (task.isCompleted && isTaskDay) {
        filteredTask.add(task);
      }
    }
    return filteredTask;
  }

  List<Task> _incompletedTask(List<Task> tasks, WidgetRef ref) {
    final selectedDate = ref.watch(dateProvider);
    final List<Task> filteredTask = [];
    for (var task in tasks) {
      final isTaskDay = Helpers.isTaskFromSelectDate(task, selectedDate);
      if (!task.isCompleted && isTaskDay) {
        filteredTask.add(task);
      }
    }
    return filteredTask;
  }

  Widget _buildDrawer(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeMode.dark;

    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/ant_logo_splash.png',
                      height: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.task_rounded),
                  title: const Text('ការងារទាំងអស់'),
                  onTap: () {
                    _showDialogWarningMessage(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('ទម្រង់ងងឹត'),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (bool value) {
                      ref.read(themeNotifierProvider.notifier).toggleTheme();
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('ការកំណត់'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bug_report),
                  title: const Text('រាយការណ៍ពីកំហុសក្នុងកម្មវិធី'),
                  onTap: () {
                    _showDialogWarningMessage(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.web),
                  title: const Text('វេបសាយរបស់សាលា'),
                  onTap: () {
                    _launchUrl();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('អំពីកម្មវិធី'),
                  onTap: () {
                    _showDeveloperInfoDialog(context);
                  },
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  'បង្កើតឡើងដោយលោក ប៉េ ពន្ធរាយ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'រក្សាសិទ្ធដោយ© 2024 ANT Technology',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // about developer
  void _showDeveloperInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('អំពីអ្នកបង្កើតកម្មវិធី'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ឈ្មោះ: ប៉េ ពន្ធរាយ'),
                Text('ឈ្មោះកម្មវិធី: ANT ToDoList'),
                Text('តួនាទី: C++/OOP and Flutter'),
                Text('សាលា: ANT Technology'),
                Text('អ៊ីម៉ែល: punreaype0@gmail.com'),
                Center(
                  child: Text('Social Media'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebookF),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.youtube),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.linkedin),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ចាកចេញ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogWarningMessage(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('សូមអភ័យទោស!'),
          content: const Text(
              "ចំពោះត្រង់ចំណុច function នេះគឺមិនដំណើរទេ!\nតែនឹងដំណើរការនៅកំណែទម្រង់ក្រោយទៀត\nសូមអរគុណ!"),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                'ចាកចេញ',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
