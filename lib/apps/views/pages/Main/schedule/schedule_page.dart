import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/models/schedule.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/utils/constant/img_assets.dart';
import 'package:healing_apps/apps/views/pages/Main/data/dummy_data.dart';
import 'package:healing_apps/apps/views/pages/Main/schedule/widget/schedule_card_widget.dart';
import 'package:healing_apps/apps/views/widgets/not_found_widget.dart';
import 'package:healing_apps/apps/views/widgets/search_input_widget.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // Gunakan data dummy sebagai state awal
  final List<Schedule> _allSchedules = dummySchedules;
  late List<Schedule> _filteredSchedules;

  @override
  void initState() {
    super.initState();
    _filteredSchedules = _allSchedules;
  }

  void _filterSchedules(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSchedules = _allSchedules;
      } else {
        _filteredSchedules = _allSchedules
            .where(
              (schedule) => schedule.destinationName.toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        // Cek apakah ada jadwal untuk ditampilkan
        child: _filteredSchedules.isEmpty
            ? NotFoundWidget(
                text:
                    "Your schedule looks empty. Let’s fill it with an unforgettable journey!",
                imagePath: AppAssets.notFoundSchedule,
                buttonText: "Explore",
              )
            : CustomScrollView(
                slivers: [
                  // --- Header ---
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hey Kiplinyu,',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Exciting journeys are already booked for you',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 24),
                          SearchInputWidget(
                            hintText: 'Mau lihat event mana dulu?',
                            onChanged: _filterSchedules,
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Your upcoming event',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // --- Daftar Jadwal ---
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final schedule = _filteredSchedules[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ScheduleCardWidget(
                          schedule: schedule,
                          onShowTicket: () {
                            // Navigasi ke halaman detail tiket
                            // Mengirim seluruh objek 'schedule' sebagai extra
                            context.push('/ticket-details', extra: schedule);
                          },
                        ),
                      );
                    }, childCount: _filteredSchedules.length),
                  ),
                ],
              ),
      ),
    );
  }
}
