import 'package:flutter_vibrate/flutter_vibrate.dart';
import './settings_manager.dart';

void hapticFeedback() {
  if (SettingsManager.isVibrateEnabled) Vibrate.feedback(FeedbackType.medium);
}
