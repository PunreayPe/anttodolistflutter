import 'package:ant_todo_list/config/routes/routes.dart';
import 'package:ant_todo_list/screens/onboardscreen/onboardscreen.dart';
import 'package:ant_todo_list/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboardingscreen extends ConsumerWidget {
  static Onboardingscreen builder(BuildContext context, GoRouterState state) =>
    Onboardingscreen();
  Onboardingscreen({super.key});
  final PageController _controller = PageController();
  final onLastPageProvider = StateProvider<bool>((ref) => false);
  bool onLastPage = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onLastPage = ref.watch(onLastPageProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index){
                ref.read(onLastPageProvider.notifier).state = (index == 4);
              },
              children: const [
                Onboard1(),
                Onboard2(),
                Onboard3(),
                Onboard4(),
                Onboard5(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    _controller.jumpToPage(5);
                  },
                  child: const Text(
                    'រំលង  ',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: const Alignment(0,0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
        
                  SmoothPageIndicator(
                    effect: JumpingDotEffect(
                      activeDotColor: context.colorScheme.primary,
                      verticalOffset: 18,
                      jumpScale: 0.9,
                      paintStyle: PaintingStyle.stroke,
                    ),
                    controller: _controller,
                    count: 5,
                  ),

                  onLastPage ?
                   ElevatedButton(
                      onPressed: () async {
                      await updateInitStatus(true);
                      Navigator.pushReplacementNamed(context, RouteLocation.home);
                    },
                    child: const Text('ចាប់ផ្តើម'),
                  ) : IconButton(
                    onPressed: () async {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.easeIn,
                      );
                    },
                    icon: FaIcon(
                      Icons.arrow_forward_ios,
                    ),
                    color: context.colorScheme.primary,
                    tooltip: 'បន្ទាប់',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
   Future<void> updateInitStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('initScreen', value);
  }
}
