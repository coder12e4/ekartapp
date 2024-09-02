import 'package:ekartapp/pages/HomePage.dart';
import 'package:ekartapp/worker/worker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

import 'cubit/kartpage/kart_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

/*
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KartCubit>(
          create: (context) => KartCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'My App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(), // Your home page widget
      ),
    );
    ;
  }
}
