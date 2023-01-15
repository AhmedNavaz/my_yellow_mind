import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:my_yellow_mind/modules/authentication/screens/createAccount.dart';
import 'package:my_yellow_mind/modules/authentication/screens/privacyPolicy.dart';
import 'package:my_yellow_mind/modules/drawer/screens/dailymovement/yogaExercises.dart';
import 'package:my_yellow_mind/modules/drawer/screens/smartwatch/smartWatchStats.dart';
import 'package:my_yellow_mind/modules/meditation/widgets/meditationPlayer.dart';
import 'package:my_yellow_mind/splash.dart';
import 'package:my_yellow_mind/widgets/mediaPlayer.dart';
import 'package:my_yellow_mind/wrapper.dart';

import 'bottomNavbar.dart';
import 'modules/authentication/screens/login.dart';
import 'modules/authentication/screens/otpConfirm.dart';
import 'modules/authentication/screens/otpSend.dart';
import 'modules/cbt/screens/liveSession.dart';
import 'modules/cbt/screens/sessionReview.dart';
import 'modules/drawer/screens/aiFriend.dart';
import 'modules/drawer/screens/dailymovement/dailyMovementHome.dart';
import 'modules/drawer/screens/dailymovement/timer.dart';
import 'modules/drawer/screens/makefriend/chatScreen.dart';
import 'modules/drawer/screens/makefriend/makeFriendHome.dart';
import 'modules/drawer/screens/moodCheck.dart';
import 'modules/drawer/screens/motivation.dart';
import 'modules/drawer/screens/smartwatch/smartWatchHome.dart';
import 'modules/drawer/screens/soothingSound.dart';
import 'modules/meditation/screens/relatedHome.dart';
import 'modules/questions/screens/welcomeScreen.dart';
import 'modules/settings/screens/exercise.dart';
import 'modules/settings/screens/feedback.dart';
import 'modules/settings/screens/mind.dart';
import 'modules/settings/screens/personal.dart';
import 'modules/settings/screens/profile.dart';
import 'modules/settings/screens/subscription.dart';
import 'modules/sleep/screens/sleepCategories.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  switch (settings.name) {
    case WrapperRoute:
      return MaterialPageRoute(builder: (context) => Wrapper());

    case SplashRoute:
      return MaterialPageRoute(builder: (context) => SplashScreen());

    case CreateAccountRoute:
      return MaterialPageRoute(builder: (context) => CreateAccountScreen());

    case LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case OtpSendRoute:
      return MaterialPageRoute(builder: (context) => OtpSendScreen());

    case OtpConfirmRoute:
      return MaterialPageRoute(builder: (context) => OtpConfirmScreen());

    case HomeScreenRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());

    case LiveSessionRoute:
      return MaterialPageRoute(
          builder: (context) => LiveSessionScreen(
                liveSession: settings.arguments as Map<String, dynamic>,
              ));

    case SleepCategoriesRoute:
      return MaterialPageRoute(
          builder: (context) => SleepCategoriesScreen(
                sleepData: settings.arguments as Map<String, dynamic>,
              ));

    case MediaPlayerRoute:
      return MaterialPageRoute(
          builder: (context) => MediaPlayerScreen(
                data: settings.arguments as Map<String, dynamic>,
              ));

    case RelatedScreenRoute:
      return MaterialPageRoute(
          builder: (context) => RelatedHomeScreen(
                categoryData: settings.arguments as Map<String, dynamic>,
              ));

    case MotivationRoute:
      return MaterialPageRoute(builder: (context) => MotivationScreen());

    case MoodCheckRoute:
      return MaterialPageRoute(builder: (context) => MoodCheckScreen());

    case SoothingSoundRoute:
      return MaterialPageRoute(builder: (context) => SoothingSoundScreen());

    case AIFriendRoute:
      return MaterialPageRoute(builder: (context) => AIFriendScreen());

    case SmartWatchRoute:
      return MaterialPageRoute(builder: (context) => SmartWatchScreen());

    case SmartWatchStatsRoute:
      return MaterialPageRoute(
          builder: (context) => SmartWatchStats(
                data: settings.arguments as Map<String, dynamic>,
              ));

    case MakeFriendRoute:
      return MaterialPageRoute(builder: (context) => MakeFriendHomeScreen());

    case ChatScreenRoute:
      return MaterialPageRoute(
          builder: (context) => ChatScreen(
                friend: settings.arguments as Map<String, dynamic>,
              ));

    case DailyMovementRoute:
      return MaterialPageRoute(builder: (context) => DailyMovementHomeScreen());

    case YogaExercisesRoute:
      return MaterialPageRoute(
          builder: (context) => YogaExercisesScreen(
                data: settings.arguments as Map<String, dynamic>,
              ));

    case WelcomScreenRoute:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());

    case ProfileScreenRoute:
      return MaterialPageRoute(builder: (context) => ProfileScreen());

    case PersonalScreenRoute:
      return MaterialPageRoute(builder: (context) => PersonalScreen());

    case FeedbackScreenRoute:
      return MaterialPageRoute(builder: (context) => FeedbackScreen());

    case SubscriptionScreenRoute:
      return MaterialPageRoute(builder: (context) => SubscriptionScreen());

    case TimerScreenRoute:
      return MaterialPageRoute(
          builder: (context) => TimerScreen(
                minutes: settings.arguments as int,
              ));

    case MindSettingsRoute:
      return MaterialPageRoute(builder: (context) => MindSettingsScreen());

    case ExerciseSettingsRoute:
      return MaterialPageRoute(builder: (context) => ExerciseSettingsScreen());

    case SessionReviewRoute:
      return MaterialPageRoute(builder: (context) => SessionReviewScreen());
    case PrivacyPolicyRoute:
      return MaterialPageRoute(builder: (context) => PrivacyPolicy());

    case MeditationPlayerRoute:
      return MaterialPageRoute(
          builder: (context) => MeditationPlayerScreen(
                data: settings.arguments as Map<String, dynamic>,
              ));

    default:
      return MaterialPageRoute(builder: (context) => CreateAccountScreen());
  }
}
