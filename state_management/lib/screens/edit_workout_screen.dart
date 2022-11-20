import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/blocks/workout_cubit.dart';
import 'package:state_management/model/exercise.dart';
import 'package:state_management/states/workout_states.dart';
import 'package:state_management/utils/helpers.dart';

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
                    onPressed: () =>
                        BlocProvider.of<WorkoutCubit>(context).goHome(),
                  ),
                ),
                body: ListView.builder(
                  // workout is emitted as a state, so we can get it here!
                    itemCount: we.workout!.exercises.length,
                    itemBuilder: (context, index) {
                      Exercise exercise = we.workout!.exercises[index];
                      return ListTile(
                        leading: Text(formatTime(exercise.prelude!, true)),
                        title: Text(exercise.title!),
                        trailing: Text(formatTime(exercise.duration!, true)),
                      );
                    }
                )
            );
          },
        ),
        // For android widget ?
        onWillPop: () => BlocProvider.of<WorkoutCubit>(context).goHome()
    );
  }
}
