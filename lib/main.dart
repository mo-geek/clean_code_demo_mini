import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nawytask/core/common_widgets/bottom_nav_bar.dart';
import 'package:nawytask/core/utils/get_it_injection.dart' as gi;

void main() async {
  await _warmingUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        //context.locale,
        title: 'Nawy',
        debugShowCheckedModeBanner: false,
        home: BottomNavBar(),
        // home: SharedPreferencesServices.getOnBoarding() == null
        //     ? const OnBoardingScreen()
        //     : const TameeniWebView(),
      ),
    );
  }
}

Future<void> _warmingUp() async {
  gi.init();
}
