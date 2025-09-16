import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/models/schedule.dart';

/// A list of dummy destination data for the Home page carousel.
final List<Destination> dummyDestinations = [
  Destination(
    id: 'dest1',
    name: 'Serenity Lake',
    location: 'Bandung, West Java',
    rating: 4.8,
    imageUrl:
        'https://images.unsplash.com/photo-1559310589-2673bfe16970?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Destination(
    id: 'dest2',
    name: 'Hidden Waterfall',
    location: 'Lombok, NTB',
    rating: 4.9,
    imageUrl:
        'https://images.unsplash.com/photo-1524338198850-8a2ff63aaceb?q=80&w=1915&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Destination(
    id: 'dest3',
    name: 'Kawah Putih',
    location: 'Ciwidey, West Java',
    rating: 4.7,
    imageUrl: 'Kawah Putih broken url',
  ),
  Destination(
    id: 'dest4',
    name: 'Raja Ampat',
    location: 'West Papua',
    rating: 5.0,
    imageUrl:
        'https://images.unsplash.com/photo-1589182373726-e4f658ab50f0?auto=format&fit=crop&q=80',
  ),
];

/// A list of dummy schedule data for the "My Schedule" page.
final List<Schedule> dummySchedules = [
  Schedule(
    id: 'sched1',
    destinationName: 'Serenity Lake',
    date: DateTime(2025, 9, 22),
    imageUrl:
        'https://images.unsplash.com/photo-1559310589-2673bfe16970?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    orderId: 'ORDER-12345',
    visitorName: 'Kiplinyu',
    ticketCount: 1,
  ),
  Schedule(
    id: 'sched2',
    destinationName: 'Kota Yogyakarta',
    date: DateTime(2025, 10, 13),
    imageUrl:
        'https://images.unsplash.com/photo-1578055648339-b67df3c862bc?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    orderId: 'ORDER-67890',
    visitorName: 'Kiplinyu',
    ticketCount: 2,
  ),
  Schedule(
    id: 'sched3',
    destinationName: 'Labuan Bajo',
    date: DateTime(2025, 10, 18),
    imageUrl: 'Labuan Bajo broken url',
    orderId: 'ORDER-11223',
    visitorName: 'Kiplinyu',
    ticketCount: 1,
  ),
  Schedule(
    id: 'sched4',
    destinationName: 'Hidden Waterfall',
    date: DateTime(2025, 11, 5),
    imageUrl:
        'https://images.unsplash.com/photo-1524338198850-8a2ff63aaceb?q=80&w=1915&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    orderId: 'ORDER-44556',
    visitorName: 'Kiplinyu',
    ticketCount: 4,
  ),
];
