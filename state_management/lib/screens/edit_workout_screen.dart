import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/blocks/workout_cubit.dart';
import 'package:state_management/blocks/workouts_cubit.dart';
import 'package:state_management/model/exercise.dart';
import 'package:state_management/model/workout.dart';
import 'package:state_management/states/workout_states.dart';
import 'package:state_management/utils/helpers.dart';

import 'edit_exercise_screen.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            WorkoutEditing we = state as WorkoutEditing;
            return Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
                  ),
                  title: InkWell(
                    child: Text(we.workout!.title!),
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) {
                        final controller = TextEditingController(text: we.workout!.title!);
                        return AlertDialog(
                          content: TextField(
                            controller: controller,
                            decoration: InputDecoration(labelText: "Workout Title"),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    Navigator.pop(context);
                                    Workout renamed = we.workout!.copyWith(title: controller.text);

                                    BlocProvider.of<WorkoutsCubit>(context).saveWorkout(renamed, we.index);
                                    BlocProvider.of<WorkoutCubit>(context).editWorkout(renamed, we.index);
                                  }
                                },
                                child: Text("Rename"))
                          ],
                        );
                      },
                    ),
                  ),
                ),
                body: ListView.builder(
                    // workout is emitted as a state, so we can get it here!
                    itemCount: we.workout!.exercises.length,
                    itemBuilder: (context, index) {
                      Exercise exercise = we.workout!.exercises[index];

                      if (we.exIndex == index) {
                        return EditExerciseScreen(workout: we.workout, index: we.index, exIndex: we.exIndex);
                      } else {
                        return ListTile(
                          leading: Text(formatTime(exercise.prelude!, true)),
                          title: Text(exercise.title!),
                          trailing: Text(formatTime(exercise.duration!, true)),
                          onTap: () => BlocProvider.of<WorkoutCubit>(context).editExercise(index),
                        );
                      }
                    }));
          },
        ),
        // For android widget ?
        onWillPop: () => BlocProvider.of<WorkoutCubit>(context).goHome());
  }
}
