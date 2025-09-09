import 'package:flutter/material.dart';
import 'package:healing_apps/apps/models/schedule.dart';

class AllSchedulePage extends StatefulWidget {
  const AllSchedulePage({super.key});

  @override
  State<AllSchedulePage> createState() => _AllSchedulePageState();
}

class _AllSchedulePageState extends State<AllSchedulePage> {
  List<Schedule> dummySchedules = [
    Schedule(
      id: "1",
      title: "Niladri Reservoir",
      location: "Tekergat, Sunamgnj",
      date: DateTime(2025, 1, 26),
      imageUrl: "https://picsum.photos/200/300?1",
    ),
    Schedule(
      id: "2",
      title: "High Rech Park",
      location: "Zeero Point, Sylhet",
      date: DateTime(2025, 1, 26),
      imageUrl: "https://picsum.photos/200/300?2",
    ),
    Schedule(
      id: "3",
      title: "Darma Reservoir",
      location: "Darma, Kuningan",
      date: DateTime(2025, 1, 26),
      imageUrl: "https://picsum.photos/200/300?3",
    ),
    Schedule(
      id: "4",
      title: "Shajek Bandorban",
      location: "Bandorban, BD",
      date: DateTime(2025, 2, 1),
      imageUrl: "https://picsum.photos/200/300?4",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Schedule"), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: dummySchedules.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final schedule = dummySchedules[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  schedule.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                schedule.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${schedule.date.day} ${_monthName(schedule.date.month)} ${schedule.date.year}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          schedule.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }
}
