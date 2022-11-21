import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/blocks/workout_cubit.dart';
import 'package:state_management/blocks/workouts_cubit.dart';
import 'package:state_management/model/workout.dart';

class EditExerciseScreen extends StatefulWidget {
  final Workout? workout;
  final int index;
  final int? exIndex;

  const EditExerciseScreen({
    Key? key,
    this.workout,
    required this.index,
    this.exIndex,
  }) : super(key: key);

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  TextEditingController? _title;

  @override
  void initState() {
    _title = TextEditingController(
        // State が widget を持つらしい。
        text: widget.workout!.exercises[widget.exIndex!].title);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextField(
              textAlign: TextAlign.center,
              controller: _title,
              onChanged: (value) => setState(() {
                widget.workout!.exercises[widget.exIndex!] =
                    widget.workout!.exercises[widget.exIndex!].copyWith(title: value);
                BlocProvider.of<WorkoutsCubit>(context).saveWorkout(widget.workout!, widget.index);
              }),
            ))
          ],
        )
      ],
    );
  }
}
