import 'package:ant_todo_list/config/theme/theme_notifier.dart';
import 'package:ant_todo_list/data/datasource/task_datasource.dart';
import 'package:ant_todo_list/data/models/task.dart';
import 'package:ant_todo_list/providers/date_provider.dart';
import 'package:ant_todo_list/providers/task/task_provider.dart';
import 'package:ant_todo_list/screens/abtdev.dart';
import 'package:ant_todo_list/screens/create_task_screen.dart';
import 'package:ant_todo_list/screens/settingscreen.dart';
import 'package:ant_todo_list/utils/utils.dart';
import 'package:ant_todo_list/widgets/display_list_of_task.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://antkh.com/');

class Homescreens extends ConsumerWidget {
  var initDate = DateTime.now();
  static Homescreens builder(BuildContext context, GoRouterState state) =>
      Homescreens(
        initDate: DateTime.now(),
      );

  Homescreens({
    super.key,
    required this.initDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TaskDataSource task = TaskDataSource();
    task.getAllTask();
    final dtCtrl = DatePickerController();
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);

    final selectDate = ref.watch(dateProvider);
    final totalTasks = taskState.tasks.length;
    final completeTask = _completedTask(taskState.tasks, selectDate);
    final completeTaskCount = totalTasks - completeTask.length;
    ;
    final incompleteTask = _incompletedTask(taskState.tasks, selectDate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dtCtrl.animateToDate(initDate);
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateTaskScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: context.colorScheme.primary,
        // You can choose an appropriate icon
        tooltip: 'បន្ថែមការងារថ្មី', // Tooltip for accessibility
      ),
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
                height: deviceSize.height * 0.26,
                width: deviceSize.width,
                color: colors.primary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    _buildHeader2(completeTaskCount, context),
                    const Gap(20),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 100,
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DatePicker(
                          controller: dtCtrl,
                          DateTime.now().subtract(Duration(days: 30)),
                          width: 72,
                          selectionColor: colors.primary,
                          initialSelectedDate: initDate,
                          selectedTextColor: colors.surfaceContainerLowest,
                          onDateChange: (selectedDate) {
                            ref.read(dateProvider.notifier).state =
                                selectedDate;
                          },
                          daysCount: 60,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ការងារដែលមិនទាន់រួចរាល់',
                        style: context.textTheme.headlineSmall,
                      ),
                      const Gap(10),
                      Expanded(
                        child: DisplayListOfTask(
                          selectedDate: selectDate,
                          tasks: incompleteTask,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        'ការងារបានធ្វើរួចរាល់',
                        style: context.textTheme.headlineSmall,
                      ),
                      const Gap(10),
                      Expanded(
                        child: DisplayListOfTask(
                          selectedDate: selectDate,
                          tasks: completeTask,
                          isCompletedTask: true,
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Task> _completedTask(List<Task> tasks, DateTime selectedDate) {
    DateTime selectedDateNormalized =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    return tasks.where((task) {
      try {
        DateTime taskDate = DateFormat('MM/dd/yyyy').parse(task.date);
        return task.isCompleted && taskDate == selectedDateNormalized;
      } catch (e) {
        print('Error parsing date for task: ${task.date}');
        return false; // Exclude this task if there's an error
      }
    }).toList();
  }

  List<Task> _incompletedTask(List<Task> tasks, DateTime selectedDate) {
    DateTime selectedDateNormalized =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    return tasks.where((task) {
      try {
        DateTime taskDate = DateFormat('MM/dd/yyyy').parse(task.date);
        return !task.isCompleted && taskDate == selectedDateNormalized;
      } catch (e) {
        print('Error parsing date for task: ${task.date}');
        return false; // Exclude this task if there's an error
      }
    }).toList();
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

  Widget _buildHeader(int task, BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              greeting(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "Kantumruy Bold",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "ការងាររបស់អ្នក(${task})",
              style: TextStyle(
                height: 1,
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w400,
                fontFamily: "Kantumruy Bold",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              DateFormat('EEEE, dd - MMM - yyyy').format(DateTime.now()),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "Kantumruy Bold",
              ),
            ),
          ),

          //seaceh bar
          Gap(13),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      IconSnackBar.show(
                        context,
                        snackBarType: SnackBarType.alert,
                        label: 'Function មិនទាន់ដំណើរការ នៅឡើយ',
                        backgroundColor: Colors.blueGrey,
                        iconColor: Colors.white,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'ស្វែងរកការងារ',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Kantumruy Reg",
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              //category
              Container(
                width: 47,
                height: 47,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    IconSnackBar.show(
                      context,
                      snackBarType: SnackBarType.alert,
                      label: 'Function មិនទាន់ដំណើរការ នៅឡើយ',
                      backgroundColor: Colors.blueGrey,
                      iconColor: Colors.white,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String greeting() {
    final hour = DateTime.now().hour;
    String greet;

    if (hour < 12) {
      greet = 'អរុណសួស្តី'; // Good morning
    } else if (hour < 18) {
      greet = 'ទិវាសួស្តី'; // Good afternoon
    } else {
      greet = 'សាយ័ណ្ហសួស្ដី'; // Good evening
    }

    return greet;
  }

  Widget _buildHeader2(int task, BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      greeting(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Kantumruy Bold",
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //   child: Text(
                  //     "ស្វាគមន៍ការត្រឡប់មកវិញ",
                  //     style: TextStyle(
                  //       height: 1,
                  //       color: Colors.white,
                  //       fontSize: 25,
                  //       fontWeight: FontWeight.w400,
                  //       fontFamily: "Kantumruy Bold",
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "ការងារដែលនៅសល់(${task})",
                      style: TextStyle(
                        height: 1,
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Kantumruy Bold",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      buildTranslatedDate(
                          DateTime.now()), // Use the custom date format
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Kantumruy Bold",
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const CreateTaskScreen(),
              //         ),
              //       );
              //     },
              //     child: Container(
              //       width: 50,
              //       height: 50,
              //       decoration: BoxDecoration(
              //         color: Colors.amber,
              //         shape: BoxShape.circle,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),

          //seaceh bar
          // Gap(30),
          // _buildCountTasks(),
          //   Gap(30),
          //   Row(
          //     children: [
          //       Expanded(
          //         child: Container(
          //           height: 50,
          //           padding: const EdgeInsets.only(left: 20, right: 10),
          //           child: TextField(
          //             readOnly: true,
          //             onTap: () {
          //               IconSnackBar.show(
          //                 context,
          //                 snackBarType: SnackBarType.alert,
          //                 label: 'Function មិនទាន់ដំណើរការ នៅឡើយ',
          //                 backgroundColor: Colors.blueGrey,
          //                 iconColor: Colors.white,
          //               );
          //             },
          //             decoration: InputDecoration(
          //               hintText: 'ស្វែងរកការងារ',
          //               hintStyle: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.w400,
          //                 fontFamily: "Kantumruy Reg",
          //               ),
          //               prefixIcon: Icon(
          //                 Icons.search,
          //                 color: Colors.white,
          //               ),
          //               border: OutlineInputBorder(
          //                 borderRadius: BorderRadius.circular(10),
          //                 borderSide: BorderSide.none,
          //               ),
          //               filled: true,
          //               fillColor: Colors.white.withOpacity(0.3),
          //             ),
          //           ),
          //         ),
          //       ),
          //       //category
          //       Container(
          //         width: 47,
          //         height: 47,
          //         margin: EdgeInsets.only(right: 20),
          //         decoration: BoxDecoration(
          //           color: Colors.white.withOpacity(0.3),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         child: IconButton(
          //           icon: Icon(
          //             Icons.filter_list,
          //             color: Colors.white,
          //           ),
          //           onPressed: () {
          //             IconSnackBar.show(
          //               context,
          //               snackBarType: SnackBarType.alert,
          //               label: 'Function មិនទាន់ដំណើរការ នៅឡើយ',
          //               backgroundColor: Colors.blueGrey,
          //               iconColor: Colors.white,
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
        ],
      ),
    );
  }

  Widget _buildCountTasks({int incomTask = 0, int comTask = 0}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              // height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.list_alt_sharp,
                        color: Colors.white,
                        size: 36,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "ការងារដែលមិនទាន់រួចរាល់",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "PV",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "${incomTask} ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: "PV",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "ការងារ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "PV",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              // height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.list_alt_sharp,
                        color: Colors.white,
                        size: 36,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "ការងារបានធ្វើរួចរាល់",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "PV",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "${comTask} ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: "PV",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "ការងារ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "PV",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, String> khmerWeekdays = {
    'Monday': 'ថ្ងៃច័ន្ទ',
    'Tuesday': 'ថ្ងៃអង្គារ',
    'Wednesday': 'ថ្ងៃពុធ',
    'Thursday': 'ថ្ងៃព្រហស្បតិ៍',
    'Friday': 'ថ្ងៃសុក្រ',
    'Saturday': 'ថ្ងៃសៅរ៍',
    'Sunday': 'ថ្ងៃអាទិត្យ',
  };

// Khmer translations for months
  Map<String, String> khmerMonths = {
    'Jan': 'មករា',
    'Feb': 'កុម្ភៈ',
    'Mar': 'មិនា',
    'Apr': 'មេសា',
    'May': 'ឧសភា',
    'Jun': 'មិថុនា',
    'Jul': 'កក្កដា',
    'Aug': 'សីហា',
    'Sep': 'កញ្ញា',
    'Oct': 'តុលា',
    'Nov': 'វិច្ឆិកា',
    'Dec': 'ធ្នូ',
  };

// Get the translated day in Khmer
  String getTranslatedDay(DateTime date) {
    String englishDay = DateFormat('EEEE').format(date); // e.g., "Monday"
    return khmerWeekdays[englishDay] ??
        englishDay; // Fallback to English if not found
  }

// Get the translated month in Khmer
  String getTranslatedMonth(String month) {
    return khmerMonths[month] ?? month; // Fallback to English if not found
  }

// Build the date text with translated day and month
  String buildTranslatedDate(DateTime date) {
    final day = getTranslatedDay(date);
    final formattedMonth = DateFormat('MMM').format(date); // e.g., "Oct"
    final month = getTranslatedMonth(formattedMonth);
    return '$day, ${DateFormat('dd').format(date)} - $month - ${date.year}';
  }
}

// class Homescreens extends ConsumerWidget {
//   static Homescreens builder(BuildContext context, GoRouterState state) =>
//       Homescreens();

//   Homescreens({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     TaskDataSource task = TaskDataSource();
//     task.getAllTask();
//     final colors = context.colorScheme;
//     final deviceSize = context.deviceSize;
//     final taskState = ref.watch(taskProvider);

//     final selectDate = ref.watch(dateProvider);
//     final totalTasks = taskState.tasks.length;
//     final completeTask = _completedTask(taskState.tasks, selectDate);
//     final incompleteTask = _incompletedTask(taskState.tasks, selectDate);

//     return Scaffold(
//       backgroundColor: context.colorScheme.primary,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               _buildHeader(1, context),
//               Gap(20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 10),
//                   height: 100,
//                   decoration: BoxDecoration(
//                     color: colors.primaryContainer,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: DatePicker(
//                     DateTime.now(),
//                     width: 72,
//                     selectionColor: colors.primary,
//                     initialSelectedDate: selectDate,
//                     selectedTextColor: colors.surfaceContainerLowest,
//                     onDateChange: (selectedDate) {
//                       ref.read(dateProvider.notifier).state = selectedDate;
//                     },
//                     daysCount: 7,
//                   ),
//                 ),
//               ),
//               // CalendarWidget(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: DisplayListOfTask(
//                   selectedDate: selectDate,
//                   tasks: incompleteTask,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(int task, BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Text(
//                       greeting(),
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         height: 1,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "Kantumruy Bold",
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     child: Text(
//                       "ស្វាគមន៍ការត្រឡប់មកវិញ",
//                       style: TextStyle(
//                         height: 1,
//                         color: Colors.white,
//                         fontSize: 25,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "Kantumruy Bold",
//                       ),
//                     ),
//                   ),
//                   // Padding(
//                   //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
//                   //   child: Text(
//                   //     "ការងាររបស់អ្នក(${task})",
//                   //     style: TextStyle(
//                   //       height: 1,
//                   //       color: Colors.white,
//                   //       fontSize: 30,
//                   //       fontWeight: FontWeight.w400,
//                   //       fontFamily: "Kantumruy Bold",
//                   //     ),
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Text(
//                       buildTranslatedDate(
//                           DateTime.now()), // Use the custom date format
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         height: 1,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "Kantumruy Bold",
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const CreateTaskScreen(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.amber,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),

//           //seaceh bar
//           Gap(30),
//           _buildCountTasks(),
//           Gap(30),
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 50,
//                   padding: const EdgeInsets.only(left: 20, right: 10),
//                   child: TextField(
//                     readOnly: true,
//                     onTap: () {
//                       IconSnackBar.show(
//                         context,
//                         snackBarType: SnackBarType.alert,
//                         label: 'Function មិនទាន់ដំណើរការ នៅឡើយ',
//                         backgroundColor: Colors.blueGrey,
//                         iconColor: Colors.white,
//                       );
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'ស្វែងរកការងារ',
//                       hintStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "Kantumruy Reg",
//                       ),
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: Colors.white,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white.withOpacity(0.3),
//                     ),
//                   ),
//                 ),
//               ),
//               //category
//               Container(
//                 width: 47,
//                 height: 47,
//                 margin: EdgeInsets.only(right: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.filter_list,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     IconSnackBar.show(
//                       context,
//                       snackBarType: SnackBarType.alert,
//                       label: 'Function មិនទាន់ដំណើរការ នៅឡើយ',
//                       backgroundColor: Colors.blueGrey,
//                       iconColor: Colors.white,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   String greeting() {
//     final hour = DateTime.now().hour;
//     String greet;

//     if (hour < 12) {
//       greet = 'អរុណសួស្តី'; // Good morning
//     } else if (hour < 18) {
//       greet = 'ទិវាសួស្តី'; // Good afternoon
//     } else {
//       greet = 'សាយ័ណ្ហសួស្ដី'; // Good evening
//     }

//     return greet;
//   }

//   Widget _buildCountTasks({int incomTask = 0, int comTask = 0}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(10),
//               // height: 100,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 1,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.list_alt_sharp,
//                         color: Colors.white,
//                         size: 36,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Text(
//                           "ការងារដែលមិនទាន់រួចរាល់",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontFamily: "PV",
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "${incomTask} ",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 25,
//                           fontFamily: "PV",
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "ការងារ",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 15,
//                           fontFamily: "PV",
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(10),
//               // height: 100,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 1,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.list_alt_sharp,
//                         color: Colors.white,
//                         size: 36,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Text(
//                           "ការងារបានធ្វើរួចរាល់",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontFamily: "PV",
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "${comTask} ",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 25,
//                           fontFamily: "PV",
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "ការងារ",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 15,
//                           fontFamily: "PV",
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Map<String, String> khmerWeekdays = {
//     'Monday': 'ថ្ងៃច័ន្ទ',
//     'Tuesday': 'ថ្ងៃអង្គារ',
//     'Wednesday': 'ថ្ងៃពុធ',
//     'Thursday': 'ថ្ងៃព្រហស្បតិ៍',
//     'Friday': 'ថ្ងៃសុក្រ',
//     'Saturday': 'ថ្ងៃសៅរ៍',
//     'Sunday': 'ថ្ងៃអាទិត្យ',
//   };

// // Khmer translations for months
//   Map<String, String> khmerMonths = {
//     'Jan': 'មករា',
//     'Feb': 'កុម្ភៈ',
//     'Mar': 'មិនា',
//     'Apr': 'មេសា',
//     'May': 'ឧសភា',
//     'Jun': 'មិថុនា',
//     'Jul': 'កក្កដា',
//     'Aug': 'សីហា',
//     'Sep': 'កញ្ញា',
//     'Oct': 'តុលា',
//     'Nov': 'វិច្ឆិកា',
//     'Dec': 'ធ្នូ',
//   };

// // Get the translated day in Khmer
//   String getTranslatedDay(DateTime date) {
//     String englishDay = DateFormat('EEEE').format(date); // e.g., "Monday"
//     return khmerWeekdays[englishDay] ??
//         englishDay; // Fallback to English if not found
//   }

// // Get the translated month in Khmer
//   String getTranslatedMonth(String month) {
//     return khmerMonths[month] ?? month; // Fallback to English if not found
//   }

// // Build the date text with translated day and month
//   String buildTranslatedDate(DateTime date) {
//     final day = getTranslatedDay(date);
//     final formattedMonth = DateFormat('MMM').format(date); // e.g., "Oct"
//     final month = getTranslatedMonth(formattedMonth);
//     return '$day, ${DateFormat('dd').format(date)} - $month - ${date.year}';
//   }

//   List<Task> _completedTask(List<Task> tasks, DateTime selectedDate) {
//     DateTime selectedDateNormalized =
//         DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

//     return tasks.where((task) {
//       try {
//         DateTime taskDate = DateFormat('MM/dd/yyyy').parse(task.date);
//         return task.isCompleted && taskDate == selectedDateNormalized;
//       } catch (e) {
//         print('Error parsing date for task: ${task.date}');
//         return false; // Exclude this task if there's an error
//       }
//     }).toList();
//   }

//   List<Task> _incompletedTask(List<Task> tasks, DateTime selectedDate) {
//     DateTime selectedDateNormalized =
//         DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

//     return tasks.where((task) {
//       try {
//         DateTime taskDate = DateFormat('MM/dd/yyyy').parse(task.date);
//         return !task.isCompleted && taskDate == selectedDateNormalized;
//       } catch (e) {
//         print('Error parsing date for task: ${task.date}');
//         return false; // Exclude this task if there's an error
//       }
//     }).toList();
//   }
// }
