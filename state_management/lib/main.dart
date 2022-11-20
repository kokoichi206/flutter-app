import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/blocks/workouts_cubit.dart';
import 'package:state_management/screens/home_page.dart';

import 'model/workout.dart';

void main() => runApp(const WorkoutTime());

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Workouts',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Color.fromARGB(255, 66, 74, 96),
          ),
        ),
      ),
      home: BlocProvider<WorkoutsCubit>(
        create: (BuildContext context) {
          WorkoutsCubit workoutsCubit = WorkoutsCubit();
          if (workoutsCubit.state.isEmpty) {
            print('Loading json ...');
            workoutsCubit.getWorkouts();
          }
          return workoutsCubit;
        },
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, state) {
            return const HomePage();
          },
        ),
      ),
    );
  }
}
