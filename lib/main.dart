import 'dart:io';

import 'package:Effexxion/global_state/global_state.dart';
import 'package:Effexxion/hive/mix_hive.dart';
import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/hive/playtime_hive.dart';
import 'package:Effexxion/hive/sleep_time_hive.dart';
import 'package:Effexxion/pages/splash_page/splash_page.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'test.dart';

final bool isIOS = Platform.isIOS;
final bool isAndroid = Platform.isAndroid;

const String appName = "Effexxion - Relax Music";
late BuildContext appContext;
late ui.Image image;
double startAngle = 0;
double angleRange = 0;
double bezierHeight = 20;
double degreeGap = 0;

Future<ui.Image> loadImage() async {
  final data = await rootBundle.load("assets/images/volume.png");
  return decodeImageFromList(data.buffer.asUint8List());
}

late Box userSettingBox;
late Box sleepTimeBox;
late Box playTimeBox;
late Box playlistBox;
late Box mixBox;

bool isPurchased = true;

Future<void> main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();
  hideStatusBar();
  setOrientationPortrait();
  image = await loadImage();
  Directory appDocDirectory = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocDirectory.path)
    ..registerAdapter(SleepTimeHiveAdapter())
    ..registerAdapter(PlayTimeHiveAdapter())
    ..registerAdapter(PlayListHiveAdapter())
    ..registerAdapter(MixHiveAdapter());

  userSettingBox = await Hive.openBox("userSettingBox");
  sleepTimeBox = await Hive.openBox("sleepTimeBox");
  playTimeBox = await Hive.openBox("playTimeBox");
  playlistBox = await Hive.openBox("playlistBox");
  mixBox = await Hive.openBox("mixBox");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<GlobalState>(create: (_) => GlobalState()),
    ],
    child: MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Avenir'),
      themeMode: ThemeMode.system,
      home: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    appContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      key: navigatorKey,
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) => MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Avenir'),
        themeMode: ThemeMode.system,
        routes: <String, WidgetBuilder>{
          // "/": (BuildContext context) => const TestPage(),
          "/": (BuildContext context) => const SplashPage(),
        },
        initialRoute: "/",
        builder: (BuildContext context, Widget? child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(data: data.copyWith(textScaleFactor: 1), child: child!);
        },
      ),
    );
  }
}
