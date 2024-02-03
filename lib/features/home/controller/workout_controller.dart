import 'package:fitness_application/features/home/repository/workout_backend_task.dart';
import 'package:fitness_application/features/home/repository/workout_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workoutControllerProvider = StateNotifierProvider<WorkoutController, bool>((ref) {
  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return WorkoutController(workoutRepository: workoutRepository, ref: ref);
});

class WorkoutController extends StateNotifier<bool> {
  final WorkoutRepository _workoutRepository;
  final Ref _ref;
  WorkoutController({
    required WorkoutRepository workoutRepository,
    required Ref ref,
  })  : _workoutRepository = workoutRepository,
        _ref = ref,
        super(false);

  void saveTodaysSteps() async {
    final steps = _ref.read(scprovider).value!.steps;
    final res = await _workoutRepository.saveTodaysSteps(steps);
  }
}
