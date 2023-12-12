import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/app_bloc.dart';
import 'package:my_app/bloc/user_bloc.dart';
import 'package:my_app/helper/toast/toast_init.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/services/utils.dart';
import 'package:sizer/sizer.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AppBloc.userBloc.add(GetUserEvent());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();

    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            scaffoldMessengerKey: Utils.messengerKey,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'HealthLife App',
            navigatorObservers: [
              NavigatorObserver(),
              BotToastNavigatorObserver(),
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            builder: toastInit(),
            home: const MainPageScreen(
              isLogin: true,
            ),
          );
        },
      ),
    );
  }
}
