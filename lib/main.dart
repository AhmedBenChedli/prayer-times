import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/prayer_times_repository.dart';
import 'screens/prayer_times_scree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PrayerTimesModel(),
      child: const MaterialApp(
        title: 'Prayer Times Demo',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PrayerTimesModel>(context);
    return PrayerTimes(model: model);
  }
}
