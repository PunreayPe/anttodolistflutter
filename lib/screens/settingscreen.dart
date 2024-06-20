import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ការកំណត់'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.font_download),
            title: const Text('ផ្លាសប្តូរFont'),
            onTap: () {
              _showDialogWarningMessage(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('ប្តូរភាសា'),
            onTap: () {
              _showDialogWarningMessage(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('ការជូនដំណឹង'),
            trailing: Switch(
              value: false,
              onChanged: (bool value) {
                _showDialogWarningMessage(context);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.surround_sound_sharp),
            title: const Text('បើកសំឡេង'),
            trailing: Switch(
              value: false,
              onChanged: (bool value) {
                _showDialogWarningMessage(context);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('គោលការណ៏'),
            onTap: () {
              _showDialogWarningMessage(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_emergency),
            title: const Text('ទំនាក់ទំនង'),
            onTap: () {
              _showDialogWarningMessage(context);
            },
          ),
        ],
      ),
    );
  }
  
  void _showDialogWarningMessage(BuildContext context) {
    showCupertinoDialog(
      context: context, 
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('សូមអភ័យទោស!'),
          content: const Text("ចំពោះត្រង់ចំណុច function នេះគឺមិនដំណើរទេ!\nតែនឹងដំណើរការនៅកំណែទម្រង់ក្រោយទៀត\nសូមអរគុណ!"),
          actions: [
            CupertinoDialogAction(
              child: const Text('ចាកចេញ',
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
