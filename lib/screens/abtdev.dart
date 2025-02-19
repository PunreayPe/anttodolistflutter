// import 'package:ant_todo_list/utils/extensions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class AboutDeveloper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.colorScheme.primaryContainer,
//       appBar: AppBar(
//         title: Text("About Developer"),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               _showDialogWarningMessage(context);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding:  EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: AssetImage('assets/images/pf.png'),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Pe Punreay',
//                 style: TextStyle(
//                   color: context.colorScheme.onPrimaryContainer,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Flutter Developer',
//                 style: TextStyle(
//                   color: context.colorScheme.onPrimaryContainer,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               SizedBox(height: 16),
//               InfoRow(label: 'Residence', value: 'Cambodia'),
//               InfoRow(label: 'City', value: 'Phnom Penh'),
//               InfoRow(label: 'Age', value: '23'),
//               SizedBox(height: 16),
//               Text(
//                 'Skills',
//                 style: TextStyle(
//                   color: context.colorScheme.onPrimaryContainer,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               SkillProgress(skill: 'C++         ', percentage: 0.7),
//               SkillProgress(skill: 'C++ OOP', percentage: 0.5),
//               SkillProgress(skill: 'Flutter    ', percentage: 0.4),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 height: 300,
//                 child: ListView.separated(
//                   separatorBuilder: (context, index) => SizedBox(
//                     width: 20,
//                   ),
//                   itemBuilder: (context, index) {
//                     return index == 0
//                         ? Container(
//                             height: 290,
//                             width: 300,
//                             child: AboutSection(),
//                           )
//                         : Container(
//                             height: 290,
//                             width: 300,
//                             child: ContactSection(),
//                           );
//                   },
//                   scrollDirection: Axis.horizontal,
//                   physics: BouncingScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: 2,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showDialogWarningMessage(BuildContext context) {
//     showCupertinoDialog(
//       context: context,
//       builder: (context) {
//         return CupertinoAlertDialog(
//           title:  Text('សូមអភ័យទោស!'),
//           content:  Text(
//               "ចំពោះត្រង់ចំណុច function នេះគឺមិនដំណើរទេ!\nតែនឹងដំណើរការនៅកំណែទម្រង់ក្រោយទៀត\nសូមអរគុណ!"),
//           actions: [
//             CupertinoDialogAction(
//               child:  Text(
//                 'ចាកចេញ',
//                 style: TextStyle(color: Colors.red),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class InfoRow extends StatelessWidget {
//   final String label;
//   final String value;

//   InfoRow({
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:  EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//                 color: context.colorScheme.onPrimaryContainer, fontSize: 16),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//                 color: context.colorScheme.onPrimaryContainer, fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SkillProgress extends StatelessWidget {
//   final String skill;
//   final double percentage;

//   SkillProgress({required this.skill, required this.percentage});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:  EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Text(
//             skill,
//             style: TextStyle(
//                 color: context.colorScheme.onPrimaryContainer, fontSize: 16),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: LinearProgressIndicator(
//               value: percentage,
//               backgroundColor: Colors.grey[800],
//               color: Colors.green,
//             ),
//           ),
//           SizedBox(width: 8),
//           Text(
//             '${(percentage * 100).toInt()}%',
//             style: TextStyle(color: context.colorScheme.onPrimaryContainer),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AboutSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: context.colorScheme.inversePrimary,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'About Me',
//             style: TextStyle(
//               color: context.colorScheme.onPrimaryContainer,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 16),
//           RichText(
//             text: TextSpan(
//               text: 'Hi, my name is ',
//               style: TextStyle(
//                   color: context.colorScheme.onPrimaryContainer, fontSize: 16),
//               children: [
//                 TextSpan(
//                   text: 'Pe Punreay',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextSpan(
//                   text:
//                       ' and I began using C++ when it first began. I spend most of my waking hours for the last ten years designing, programming, and operating Flutter sites that go beyond the exclusive designer.',
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SkillChip(label: 'Khmer ', percentage: 99),
//               SkillChip(label: 'English', percentage: 60),
//             ],
//           ),
//           SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }

// class SkillChip extends StatelessWidget {
//   final String label;
//   final int percentage;

//   SkillChip({
//     required this.label,
//     required this.percentage,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Chip(
//         label: Text(
//           '$label ($percentage%)',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: context.colorScheme.primary);
//   }
// }

// class ContactSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: context.colorScheme.inversePrimary,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Contact Me',
//             style: TextStyle(
//               color: context.colorScheme.onPrimaryContainer,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 16),
//           ContactInfoRow(
//             icon: Icons.location_on,
//             label: 'Location',
//             value: 'Svay park, Reussey keo, Phnom Penh',
//           ),
//           ContactInfoRow(
//             icon: Icons.email,
//             label: 'E-mail',
//             value: 'punreaype0gmail.com',
//           ),
//           ContactInfoRow(
//             icon: Icons.phone,
//             label: 'Phone',
//             value: '+855 69 399 396',
//           ),
//           SizedBox(height: 16),
//           // Additional form fields could be added here.
//         ],
//       ),
//     );
//   }
// }

// class ContactInfoRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;

//   ContactInfoRow({
//     required this.icon,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 260,
//       padding:  EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.green),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                       color: context.colorScheme.onPrimaryContainer,
//                       fontSize: 16),
//                 ),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     color: context.colorScheme.onPrimaryContainer,
//                     fontSize: 16,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   maxLines: 1,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:ant_todo_list/utils/extensions.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDeveloper extends StatefulWidget {
  AboutDeveloper({super.key});

  @override
  State<AboutDeveloper> createState() => _AboutDeveloperState();
}

class _AboutDeveloperState extends State<AboutDeveloper> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: AboutMeContent(context));
    return DraggableHome(
        title: titlebar(),
        backgroundColor: context.colorScheme.primaryContainer,
        headerWidget: aboutmeHeader(),
        alwaysShowLeadingAndAction: false,
        actions: [Container()],
        curvedBodyRadius: 20,
        body: [SafeArea(top: false, child: AboutMeContent(context))]);
  }

  Widget aboutmeHeader() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg.png'), // Replace with your image asset
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
          color: context.colorScheme.onPrimaryContainer),
      child: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: Image.asset('assets/icons/ANT_TODOLIST_Icons.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ANT TODO LIST",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppin',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Text(
                      "រក្សាសិទ្ធដោយ ANT Technology",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget titlebar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: SizedBox(
            width: 42,
            height: 42,
            child: Image.asset('assets/icons/ANT_TODOLIST_Icons.png'),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ANT TODO LIST",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppin',
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              "រក្សាសិទ្ធដោយ ANT Technology",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 0.0),
          child: SizedBox(
            width: 42,
            height: 42,
            child: Bounceable(
              onTap: () async {
                final url = Uri.parse(
                  "https://www.facebook.com/pe.punreay",
                );
                if (await canLaunchUrl(url)) {
                  launchUrl(url);
                } else {
                  // ignore: avoid_print

                  print("Can't launch $url");
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: Image.asset(
                  'assets/images/pf.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget AboutMeContent(BuildContext context) {
    final exWidth = MediaQuery.sizeOf(context).width / 5;
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pe\nPunreay",
                      style: TextStyle(
                          fontSize: 50,
                          fontFamily: "AB",
                          fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, right: 50),
                      child: Text(
                        "_____",
                        style: TextStyle(fontSize: 20, fontFamily: ""),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 14.0),
                  child: Text(
                    "Software Developer",
                    style: TextStyle(fontSize: 20, fontFamily: "AB"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 14.0, right: 20),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "University/School",
                            style: TextStyle(fontSize: 19, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "RUPP/ANT",
                            style: TextStyle(fontSize: 13, fontFamily: "AB"),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "Major",
                            style: TextStyle(fontSize: 19, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "CS",
                            style: TextStyle(fontSize: 13, fontFamily: "AB"),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "Project Title",
                            style: TextStyle(fontSize: 19, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "ANT TODO LIST",
                            style: TextStyle(fontSize: 13, fontFamily: "AB"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About Dev",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "AB",
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onPrimaryContainer),
                      ),
                      Text(
                        "____",
                        style: TextStyle(fontSize: 20, fontFamily: ""),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: RichText(
                      text: TextSpan(
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontFamily: "PV",
                                  fontSize: 17,
                                  color: context.colorScheme.onPrimaryContainer,
                                ),
                        children: [
                          TextSpan(
                            text: "សួរស្តី! ខ្ញុំបាទឈ្មោះ ",
                          ),
                          TextSpan(
                            text: "ប៉េ ពន្ធរាយ ",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text:
                                "ជាសិស្សនិស្សិត នៃ សកលវិទ្យាល័យភូមិន្នភ្នំពេញ ផ្នែក វិទ្យាសាស្ត្រ​កុំព្យូទ័រ និង ថ្នាក់បណ្តុះបណ្តាលជំនាញបច្ចេកវិទ្យា អាន-ANT ។ ",
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About Project",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "AB",
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "____",
                        style: TextStyle(fontSize: 20, fontFamily: ""),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontFamily: "PV",
                          fontSize: 17,
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                    children: [
                      TextSpan(
                        text:
                            "Project នេះត្រូវបានបង្កើតឡើងសម្រាប់ការ បញ្ចប់ការសិក្សាវគ្គ Flutter Level 1 នៅសាលាបណ្តុះបណ្តាលជំនាញបច្ចេកវិទ្យា អាន-ANT ដែលបានបង្រៀនយ៉ាងយកចិត្តទុកដាក់ដោយ ",
                      ),
                      TextSpan(
                        text: "លោកគ្រូ ម៉ម ចាន់វិឆៃ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Resume",
                  style: TextStyle(
                      fontSize: 70,
                      fontFamily: "AB",
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "(01)",
                      style: TextStyle(fontSize: 15, fontFamily: "AB"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: exWidth - 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Experience",
                            style: TextStyle(fontSize: 30, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Programming Instructor",
                                    style: TextStyle(
                                        fontSize: 17, fontFamily: "AB"),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ANT",
                                        style: TextStyle(
                                            fontSize: 13, fontFamily: "AB"),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        "June '23 - Present",
                                        style: TextStyle(
                                            fontSize: 13, fontFamily: "AB"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(
                            width: exWidth * 3,
                            height: 20,
                            child: Divider(
                              height: 1,
                              thickness: 1, // Optional, for clarity
                              color: Colors.grey, // Adjust color as needed
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Instructor's Assistance",
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: "AB"),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ANT",
                                        style: TextStyle(
                                            fontSize: 13, fontFamily: "AB"),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Jan '22 - June '23",
                                        style: TextStyle(
                                            fontSize: 13, fontFamily: "AB"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: exWidth * 3,
                            height: 20,
                            child: Divider(
                              height: 1,
                              thickness: 1, // Optional, for clarity
                              color: Colors.grey, // Adjust color as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "(02)",
                      style: TextStyle(fontSize: 15, fontFamily: "AB"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: exWidth - 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Education",
                            style: TextStyle(fontSize: 30, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Royal University of Phnom Penh",
                                style:
                                    TextStyle(fontSize: 17, fontFamily: "AB"),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Computer Science & Engineering",
                                    style: TextStyle(
                                        fontSize: 13, fontFamily: "AB"),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "'19 - '23",
                                    style: TextStyle(
                                        fontSize: 13, fontFamily: "AB"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: exWidth * 3 + 30,
                            height: 20,
                            child: Divider(
                              height: 1,
                              thickness: 1, // Optional, for clarity
                              color: Colors.grey, // Adjust color as needed
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ANT Technology Training Center",
                                style:
                                    TextStyle(fontSize: 17, fontFamily: "AB"),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Short Courses",
                                    style: TextStyle(
                                        fontSize: 13, fontFamily: "AB"),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "'19 - '23",
                                    style: TextStyle(
                                        fontSize: 13, fontFamily: "AB"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: exWidth * 3 + 30,
                            height: 20,
                            child: Divider(
                              height: 1,
                              thickness: 1, // Optional, for clarity
                              color: Colors.grey, // Adjust color as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "(03)",
                      style: TextStyle(fontSize: 15, fontFamily: "AB"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: exWidth + 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Skills",
                            style: TextStyle(fontSize: 20, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "C++ / OOP",
                            style: TextStyle(fontSize: 15, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "C# / .Net",
                            style: TextStyle(fontSize: 15, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "JAVA",
                            style: TextStyle(fontSize: 15, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Python",
                            style: TextStyle(fontSize: 15, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Flutter / Dart",
                            style: TextStyle(fontSize: 15, fontFamily: "AB"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lanaguages",
                            style: TextStyle(fontSize: 20, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "English",
                            style: TextStyle(fontSize: 15, fontFamily: "AB"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Khmer",
                            style: TextStyle(fontSize: 15, fontFamily: "AB"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          //  Padding(
          //   padding: EdgeInsets.all(20.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Text(
          //         "Explore More",
          //         style: TextStyle(
          //             fontSize: 25,
          //             fontFamily: "AB",
          //             fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         "____",
          //         style: TextStyle(fontSize: 20, fontFamily: ""),
          //       ),
          //     ],
          //   ),
          // ),
          //  AboutMe(),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 30, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Other Projects",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "AB",
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "____",
                  style: TextStyle(fontSize: 20, fontFamily: ""),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 200,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/project1.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                // Add the button with a fading black background
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7), // Start with black
                          Colors.black.withOpacity(0.6), // Fade to transparent
                          Colors.black.withOpacity(0.5), // Fade to transparent
                          Colors.black.withOpacity(
                              0.3), // Fade to transp Colors.black.withOpacity(0.1), // Fade to transparent
                          Colors.black.withOpacity(0.0), // Fade to transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ប្រព័ន្ធគ្រប់គ្រងហាងកាហ្វេ ANT', // Your desired text
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'C++', // Your desired text
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Center(
              child: Text(
                'បង្កើតឡើងដោយលោក ប៉េ ពន្ធរាយ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Center(
              child: Text(
                'រក្សាសិទ្ធដោយ© 2024 ANT Technology',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
