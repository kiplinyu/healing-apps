import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:healing_apps/apps/models/user_model.dart';
import 'package:healing_apps/apps/services/backend_controller_service.dart';

class UserNotifier extends StateNotifier<UserModel?>
{
    UserNotifier() : super(null);

    void setUser(UserModel user) 
    {
        state = user;
    }

    void clearUser() 
    {
        state = null;
    }
}

// Provider global (harus di luar class)
final userProvider = StateNotifierProvider<UserNotifier, UserModel?>(
    (ref) => UserNotifier(),
);

final getUserProvider = FutureProvider<UserModel>((ref) async
    {

        final BackendControllerService backendService = BackendControllerService();
        final response = await backendService.getUser();
        if (response == null) 
        {
            throw Exception('Failed to fetch user');
        }
        ref.read(userProvider.notifier).setUser(response);
        return response;
    }
);
