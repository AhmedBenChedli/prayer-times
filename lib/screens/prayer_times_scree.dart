import 'package:flutter/material.dart';
import '../providers/prayer_times_repository.dart';

class PrayerTimes extends StatefulWidget {
  const PrayerTimes({
    Key? key,
    required this.model,
  }) : super(key: key);

  final PrayerTimesModel model;

  @override
  State<PrayerTimes> createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes> {
bool fetchError =false;

  Widget _buildPrayerTimeTile({
    required String title,
    required String time,
  }) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    trailing: Text(
      time,
      style: const TextStyle(
        fontSize: 18,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Text(
              'Enter city name:',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: widget.model.cityController,
              decoration: InputDecoration(
                hintText: 'e.g. New York',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                    fetchError =false;
                  });
                try{
                await widget.model.fetchPrayerTimes();
                }catch(e){
                  debugPrint(e.toString());
                  setState(() {
                    fetchError =true;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Get prayer times'),
            ),
            const SizedBox(height: 16),
            if (widget.model.isLoading && !fetchError)
              const Center(child: CircularProgressIndicator())
            else if (widget.model.timings != null)
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView (
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'Prayer times for ${widget.model.cityController.text}:',
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildPrayerTimeTile(
                            title: 'Fajr',
                            time: widget.model.timings!['Fajr']!,
                          ),
                          _buildPrayerTimeTile(
                            title: 'Sunrise',
                            time: widget.model.timings!['Sunrise']!,
                          ),
                          _buildPrayerTimeTile(
                            title: 'Dhuhr',
                            time: widget.model.timings!['Dhuhr']!,
                          ),
                          _buildPrayerTimeTile(
                            title: 'Asr',
                            time: widget.model.timings!['Asr']!,
                          ),
                          _buildPrayerTimeTile(
                            title: 'Maghrib',
                            time: widget.model.timings!['Maghrib']!,
                          ),
                          _buildPrayerTimeTile(
                            title: 'Isha',
                            time: widget.model.timings!['Isha']!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }}