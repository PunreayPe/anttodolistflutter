import 'package:ant_todo_list/data/models/task.dart';
import 'package:ant_todo_list/providers/providers.dart';
import 'package:ant_todo_list/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppAlerts {
  AppAlerts._();

  static displaySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyLarge
              ?.copyWith(color: context.colorScheme.surface),
        ),
        backgroundColor: context.colorScheme.primary,
      ),
    );
  }

  static newdisplaySnackBar(BuildContext context, String message,
      {bool isCom = true}) {
    IconSnackBar.show(
      context,
      snackBarType: isCom ? SnackBarType.success : SnackBarType.fail,
      label: message,
    );
  }

  static newdisplaySnackBar2(BuildContext context, String message,
      {int isCom = 0}) {
    IconSnackBar.show(
      context,
      snackBarType: isCom == 0
          ? SnackBarType.success
          : isCom == 1
              ? SnackBarType.fail
              : SnackBarType.alert,
      label: message,
    );
  }

  static Future<void> showDeleteAlertDialog(
      BuildContext context, WidgetRef ref, Task tasks) async {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('ទេ!អរគុណ'),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref.read(taskProvider.notifier).deleteTask(tasks).then((value) {
          AppAlerts.displaySnackBar(context, 'បានលុបការងារ');
          Navigator.pop(context);
        });
      },
      child: const Text('បាទ/ចាស'),
    );
    AlertDialog alert = AlertDialog(
      title: const Text('តើអ្នកចង់លុបមែនឬទេ? '),
      actions: [deleteButton, cancelButton],
    );

    await showDialog(
        context: context,
        builder: (ctx) {
          return alert;
        });
  }
}
