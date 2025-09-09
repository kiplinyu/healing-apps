import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:healing_apps/apps/models/schedule.dart';
import 'all_schedule_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentWeekStart = DateTime.now();

  // Dummy data
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
  void initState() {
    super.initState();
    _currentWeekStart = _getStartOfWeek(DateTime.now());
  }

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday % 7));
  }

  List<DateTime> _getDaysInWeek(DateTime weekStart) {
    return List.generate(7, (i) => weekStart.add(Duration(days: i)));
  }

  void _goToPreviousWeek() {
    setState(() {
      _currentWeekStart = _currentWeekStart.subtract(const Duration(days: 7));
    });
  }

  void _goToNextWeek() {
    setState(() {
      _currentWeekStart = _currentWeekStart.add(const Duration(days: 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = _getDaysInWeek(_currentWeekStart);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header tanggal + navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat("d MMMM").format(_selectedDate),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _goToPreviousWeek,
                      icon: const Icon(Icons.chevron_left),
                    ),
                    IconButton(
                      onPressed: _goToNextWeek,
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Weekly calendar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: daysOfWeek.map((day) {
                final isSelected =
                    day.day == _selectedDate.day &&
                    day.month == _selectedDate.month &&
                    day.year == _selectedDate.year;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = day;
                    });
                  },
                  child: Container(
                    width: 40,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat("E").format(day).substring(0, 1),
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          day.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Schedule",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AllSchedulePage(),
                      ),
                    );
                  },
                  child: const Text(
                    "View all",
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            /// Schedule List (filter by selected date)
            Expanded(
              child: ListView.separated(
                itemCount: dummySchedules
                    .where(
                      (s) =>
                          s.date.year == _selectedDate.year &&
                          s.date.month == _selectedDate.month &&
                          s.date.day == _selectedDate.day,
                    )
                    .length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final schedulesForDay = dummySchedules
                      .where(
                        (s) =>
                            s.date.year == _selectedDate.year &&
                            s.date.month == _selectedDate.month &&
                            s.date.day == _selectedDate.day,
                      )
                      .toList();
                  final schedule = schedulesForDay[index];
                  return _scheduleCard(schedule);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scheduleCard(Schedule schedule) {
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
              DateFormat("d MMMM yyyy").format(schedule.date),
              style: const TextStyle(fontSize: 12),
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    schedule.location,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
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
  }
}
