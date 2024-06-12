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
              // Handle language change
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('ប្តូរភាសា'),
            onTap: () {
              // Handle language change
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('ការជូនដំណឹង'),
            trailing: Switch(
              value: false, // Replace with actual notification state
              onChanged: (bool value) {
                // Handle notification toggle
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.surround_sound_sharp),
            title: const Text('បើកសំឡេង'),
            trailing: Switch(
              value: false, // Replace with actual notification state
              onChanged: (bool value) {
                // Handle notification toggle
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('គោលការណ៏'),
            onTap: () {
              // Navigate to privacy policy screen or show dialog
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_emergency),
            title: const Text('ទំនាក់ទំនង'),
            onTap: () {
              // Handle language change
            },
          ),
        ],
      ),
    );
  }
}
