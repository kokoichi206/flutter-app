import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/blocks/workout_cubit.dart';
import 'package:state_management/states/workout_states.dart';
import 'package:state_management/utils/helpers.dart';

import '../model/exercise.dart';
import '../model/workout.dart';

class WorkoutInProgressScreen extends StatelessWidget {
  const WorkoutInProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _getStats(Workout workout, int workoutElapsed) {
      int workoutTotal = workout.getTotal();
      Exercise exercise = workout.getCurrentExercise(workoutElapsed);
      int exerciseElapsed = workoutElapsed - exercise.startTime!;

      int exerciseRemaining = exercise.prelude! - exerciseElapsed;
      bool isPrelude = exerciseElapsed < exercise.prelude!;
      int exerciseTotal = isPrelude ? exercise.prelude! : exercise.duration!;
      if (!isPrelude) {
        exerciseElapsed -= exercise.prelude!;
        exerciseRemaining += exercise.duration!;
      }

      return {
        "workoutTitle": workout.title,
        "workoutProgress": workoutElapsed / workoutTotal,
        "workoutElapsed": workoutElapsed,
        "totalExercise": workout.exercises.length,
        "currentExerciseIndex": exercise.index!.toDouble(),
        "workoutRemaining": workoutTotal - workoutElapsed,
        "exerciseRemaining": exerciseRemaining,
        "exerciseProgress": exerciseElapsed / exerciseTotal,
        "isPrelude": isPrelude,
      };
    }

    return BlocConsumer<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        final stats = _getStats(state.workout!, state.elapsed!);
        return Scaffold(
          appBar: AppBar(
            title: Text(state.workout!.title.toString()),
            leading: BackButton(
              onPressed: BlocProvider.of<WorkoutCubit>(context).goHome,
            ),
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    backgroundColor: Colors.blue[100],
                    minHeight: 10,
                    value: stats["workoutProgress"],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(stats["workoutElapsed"], true)),
                        DotsIndicator(
                          dotsCount: stats["totalExercise"],
                          position: stats["currentExerciseIndex"],
                        ),
                        Text("-${formatTime(stats["workoutRemaining"], true)}"),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: (){
                      if (state is WorkoutInProgress) {
                        BlocProvider.of<WorkoutCubit>(context)
                            .pauseWorkout();
                      } else if (state is WorkoutPaused) {
                        BlocProvider.of<WorkoutCubit>(context)
                            .resumeWorkout();
                      }
                    },
                    child: Stack(
                      alignment: const Alignment(0, 0),
                      children: [
                        Center(
                          child: SizedBox(
                            height: 220,
                            width: 220,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(stats["isPrelude"] ? Colors.red : Colors.blue),
                              strokeWidth: 25,
                              value: stats["exerciseProgress"],
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Image.asset("stopwatch.png"),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
