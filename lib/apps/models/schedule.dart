/// Represents the data structure for a single scheduled trip.
class Schedule {
  final String id;
  final String destinationName;
  final String imageUrl;
  final DateTime date;

  Schedule({
    required this.id,
    required this.destinationName,
    required this.imageUrl,
    required this.date,
  });
}
