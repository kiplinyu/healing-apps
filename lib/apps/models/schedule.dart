/// Represents the data structure for a single scheduled trip.
class Schedule {
  final String id;
  final String destinationName;
  final String imageUrl;
  final DateTime date;
  final String orderId;
  final String visitorName;
  final int ticketCount;

  Schedule({
    required this.id,
    required this.destinationName,
    required this.imageUrl,
    required this.date,
    required this.orderId,
    required this.visitorName,
    required this.ticketCount,
  });
}
