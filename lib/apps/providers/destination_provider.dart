import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/services/backend_controller_service.dart';

class DestinationProvider extends StateNotifier<Destination?>
{

    DestinationProvider() : super(null);

    // Implementation of DestinationProvider
}

final destinationProvider = StateNotifierProvider<DestinationProvider, Destination?>(
    (ref) => DestinationProvider(),
);

final getDestinationsProvider = FutureProvider<List<Destination>>((ref) async
    {
        final BackendControllerService backendService = BackendControllerService();
        final response = await backendService.getDestinations();
        if (response == null)
        {
            throw Exception('Failed to fetch destinations');
        }
        List<Destination> destinations = response;
        return destinations;
    }
);
