import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_yellow_mind/modules/authentication/provider/authProvider.dart';
import 'package:my_yellow_mind/modules/cbt/providers/cbtProvider.dart';
import 'package:my_yellow_mind/modules/drawer/providers/dailyMovementProvider.dart';
import 'package:my_yellow_mind/modules/drawer/providers/moodCheckProvider.dart';
import 'package:my_yellow_mind/modules/meditation/provider/meditationProvider.dart';
import 'package:my_yellow_mind/modules/questions/providers/questionProvider.dart';
import 'package:my_yellow_mind/modules/settings/provider/categoriesProvider.dart';
import 'package:my_yellow_mind/modules/settings/provider/profileProvider.dart';
import 'package:my_yellow_mind/modules/settings/provider/subscriptionProvider.dart';
import 'package:my_yellow_mind/services/Scroll_behavior.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'constants/routeNames.dart';
import 'modules/drawer/providers/budyyProvider.dart';
import 'modules/drawer/providers/chatbotProvider.dart';
import 'modules/drawer/providers/friendsProvider.dart';
import 'modules/drawer/providers/motivationProvider.dart';
import 'modules/drawer/providers/soothingSoundProvider.dart';
import 'modules/sleep/providers/sleepProvider.dart';
import 'router.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MeditationProvider()),
        ChangeNotifierProvider(create: (_) => SleepProvider()),
        ChangeNotifierProvider(create: (_) => SoothingSoundProvider()),
        ChangeNotifierProvider(create: (_) => FriendsProvider()),
        ChangeNotifierProvider(create: (_) => DailyMovementProvider()),
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
        ChangeNotifierProvider(create: (_) => CBTProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => MoodCheckProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => MotivationProvider()),
        ChangeNotifierProvider(create: (_) => ChatbotProvider()),
        ChangeNotifierProvider(create: (_) => BuddyProvider()),
      ],
      child: MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, child!),
            maxWidth: 1200,
            minWidth: 450,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        color: Colors.amber,
        title: 'My Yellow Mind',
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        onGenerateRoute: router.generateRoute,
        initialRoute: WrapperRoute,
      ),
    );
  }
}
