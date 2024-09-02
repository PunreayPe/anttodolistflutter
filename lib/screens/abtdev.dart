import 'package:ant_todo_list/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutDeveloper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primaryContainer,
      appBar: AppBar(
        title: Text("About Developer"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showDialogWarningMessage(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/pf.png'),
              ),
              SizedBox(height: 16),
              Text(
                'Pe Punreay',
                style: TextStyle(
                  color: context.colorScheme.onPrimaryContainer,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Flutter Developer',
                style: TextStyle(
                  color: context.colorScheme.onPrimaryContainer,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16),
              InfoRow(label: 'Residence', value: 'Cambodia'),
              InfoRow(label: 'City', value: 'Phnom Penh'),
              InfoRow(label: 'Age', value: '23'),
              SizedBox(height: 16),
              Text(
                'Skills',
                style: TextStyle(
                  color: context.colorScheme.onPrimaryContainer,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              SkillProgress(skill: 'C++         ', percentage: 0.7),
              SkillProgress(skill: 'C++ OOP', percentage: 0.5),
              SkillProgress(skill: 'Flutter    ', percentage: 0.4),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    width: 20,
                  ),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Container(
                            height: 290,
                            width: 300,
                            child: AboutSection(),
                          )
                        : Container(
                            height: 290,
                            width: 300,
                            child: ContactSection(),
                          );
                  },
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                ),
              ),
            ],
          ),
        ),
      ),
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

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                color: context.colorScheme.onPrimaryContainer, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(
                color: context.colorScheme.onPrimaryContainer, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class SkillProgress extends StatelessWidget {
  final String skill;
  final double percentage;

  SkillProgress({required this.skill, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            skill,
            style: TextStyle(
                color: context.colorScheme.onPrimaryContainer, fontSize: 16),
          ),
          SizedBox(width: 16),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[800],
              color: Colors.green,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '${(percentage * 100).toInt()}%',
            style: TextStyle(color: context.colorScheme.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: TextStyle(
              color: context.colorScheme.onPrimaryContainer,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          RichText(
            text: TextSpan(
              text: 'Hi, my name is ',
              style: TextStyle(
                  color: context.colorScheme.onPrimaryContainer, fontSize: 16),
              children: [
                TextSpan(
                  text: 'Pe Punreay',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      ' and I began using C++ when it first began. I spend most of my waking hours for the last ten years designing, programming, and operating Flutter sites that go beyond the exclusive designer.',
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkillChip(label: 'Khmer ', percentage: 99),
              SkillChip(label: 'English', percentage: 60),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  final String label;
  final int percentage;

  SkillChip({
    required this.label,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
        label: Text(
          '$label ($percentage%)',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: context.colorScheme.primary);
  }
}

class ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Me',
            style: TextStyle(
              color: context.colorScheme.onPrimaryContainer,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ContactInfoRow(
            icon: Icons.location_on,
            label: 'Location',
            value: 'Svay park, Reussey keo, Phnom Penh',
          ),
          ContactInfoRow(
            icon: Icons.email,
            label: 'E-mail',
            value: 'punreaype0gmail.com',
          ),
          ContactInfoRow(
            icon: Icons.phone,
            label: 'Phone',
            value: '+855 69 399 396',
          ),
          SizedBox(height: 16),
          // Additional form fields could be added here.
        ],
      ),
    );
  }
}

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ContactInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                      color: context.colorScheme.onPrimaryContainer,
                      fontSize: 16),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: context.colorScheme.onPrimaryContainer,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
