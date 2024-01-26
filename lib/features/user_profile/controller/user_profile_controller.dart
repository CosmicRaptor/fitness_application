import 'package:fitness_application/features/user_profile/repository/user_profile_repository.dart';
import 'package:fitness_application/models/workout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileControllerProvider = StateNotifierProvider<UserProfileController, bool>((ref) {
  final userProfileRepository = ref.watch(userProfileRepositoryProvider);
  return UserProfileController(userProfileRepository: userProfileRepository, ref: ref);
});

class UserProfileController extends StateNotifier<bool> {
  final UserProfileRepository _userProfileRepository;
  final Ref _ref;

  UserProfileController(
      {required UserProfileRepository userProfileRepository, required Ref ref})
      : _userProfileRepository = userProfileRepository,
        _ref = ref,
        super(false);

  Stream<List<Workout>> getUserWorkout(String uid){
    return _userProfileRepository.getWorkouts(uid);
  }
}
