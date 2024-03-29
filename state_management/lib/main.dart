import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:state_management/blocks/workout_cubit.dart';
import 'package:state_management/blocks/workouts_cubit.dart';
import 'package:state_management/screens/edit_workout_screen.dart';
import 'package:state_management/screens/home_page.dart';
import 'package:state_management/screens/workout_in_progress_screen.dart';
import 'package:state_management/states/workout_states.dart';
import 'package:state_management/utils/workmanager.dart';
import 'package:workmanager/workmanager.dart';

import 'model/workout.dart';

void main() async {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();

    print("Platform is Android, so the WorkManager setup is called.");
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    Workmanager().registerPeriodicTask(
      "this.should.be.a.unique.name",
      "mySimpleTask",
      frequency: const Duration(minutes: 15), //
    );
  }

  final storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(() => runApp(const WorkoutTime()), storage: storage);
}

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
        home: MultiBlocProvider(
            providers: [
              BlocProvider<WorkoutsCubit>(
                create: (BuildContext context) {
                  WorkoutsCubit workoutsCubit = WorkoutsCubit();
                  if (workoutsCubit.state.isEmpty) {
                    print('Loading json ...');
                    workoutsCubit.getWorkouts();
                  }
                  return workoutsCubit;
                },
              ),
              BlocProvider<WorkoutCubit>(
                create: (BuildContext context) => WorkoutCubit(),
              )
            ],
            child: BlocBuilder<WorkoutCubit, WorkoutState>(
              builder: (context, state) {
                print("main.dart BlocBuilder: state ${state}");
                if (state is WorkoutInitial) {
                  return const HomePage();
                } else if (state is WorkoutEditing) {
                  return const EditWorkoutScreen();
                }
                return const WorkoutInProgressScreen();
              },
            )));
  }
}
