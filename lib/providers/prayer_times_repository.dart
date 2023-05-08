import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrayerTimesModel with ChangeNotifier {
  final cityController = TextEditingController();
  Map<String, dynamic>? _timings;
  bool _isLoading = false;

  Map<String, dynamic>? get timings => _timings;
  bool get isLoading => _isLoading;

  Future<void> fetchPrayerTimes() async {
    _isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.parse(
        'https://api.aladhan.com/v1/timingsByCity?city=${cityController.text}&country=any&method=2'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, dynamic> timings = data['data']['timings'];
      _timings = timings;
      _isLoading = false;
      notifyListeners();
    } else {
       _isLoading = false;
      throw Exception('Failed to fetch prayer times');
    }
  }
}
