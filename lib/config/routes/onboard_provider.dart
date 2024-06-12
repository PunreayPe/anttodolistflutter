import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, bool>((ref) {
  return OnboardingNotifier();
});

class OnboardingNotifier extends StateNotifier<bool> {
  OnboardingNotifier() : super(false) {
    _loadOnboardingStatus();
  }

  Future<void> _loadOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('onboardingCompleted') ?? false;
    print('Onboarding status loaded: $state');
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    state = true;
    await prefs.setBool('onboardingCompleted', true);
    print('Onboarding status saved: ${prefs.getBool('onboardingCompleted')}');
  }
}
