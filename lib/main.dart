import 'package:flutter/material.dart';
import 'package:track_distance/core/utils/size_config.dart';
import 'package:track_distance/data/backround_service.dart';
import 'package:track_distance/presentation/screens/tracking/tracking_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeBackgroundFetch();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tracking App',
      home: TrackingScreen(),
    );
  }
}
