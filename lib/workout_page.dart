import 'dart:async';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  double _totalCaloriesBurned = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _createBodyPartTile(context, 'Chest', Icons.accessibility),
                _createBodyPartTile(context, 'Legs', Icons.directions_walk),
                _createBodyPartTile(context, 'Abs', Icons.fitness_center),
                _createBodyPartTile(context, 'Shoulder', Icons.arrow_upward),
                _createBodyPartTile(context, 'Biceps', Icons.fitness_center),
                _createBodyPartTile(context, 'Neck', Icons.accessibility_new),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Calories Burned',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                ProgressBar(totalCaloriesBurned: _totalCaloriesBurned),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createBodyPartTile(BuildContext context, String bodyPart, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExercisePage(
              exerciseName: '$bodyPart Exercise',
              onCaloriesBurned: (calories) {
                setState(() {
                  _totalCaloriesBurned += calories;
                });
              },
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                bodyPart,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExercisePage extends StatefulWidget {
  final String exerciseName;
  final ValueChanged<double> onCaloriesBurned;

  ExercisePage({
    required this.exerciseName,
    required this.onCaloriesBurned,
  });

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late Timer _timer;
  int _elapsedSeconds = 0;
  final int _totalDurationInSeconds = 60; // 5 minutes exercise duration

  // Calories burned per second
  final double _caloriesPerSecond = 0.1;

  @override
  Widget build(BuildContext context) {
    double progress = _elapsedSeconds / _totalDurationInSeconds;
    double caloriesBurned = _elapsedSeconds * _caloriesPerSecond;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exerciseName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              // Replace with the actual exercise GIF
              'assets/images/pushup.gif',
              width: 200,
              height: 200,
            ),
          ),
          SizedBox(height: 20),
          Text(
            widget.exerciseName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_elapsedSeconds ~/ 60}:${_elapsedSeconds % 60}',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 150,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.lightBlue],
                    ),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _startTimer();
            },
            child: Text('Start'),
          ),
          SizedBox(height: 20),
          Text(
            'Calories Burned: ${caloriesBurned.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_elapsedSeconds < _totalDurationInSeconds) {
          _elapsedSeconds++;
        } else {
          _timer.cancel();
          widget.onCaloriesBurned(_elapsedSeconds * _caloriesPerSecond);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class ProgressBar extends StatelessWidget {
  final double totalCaloriesBurned;

  const ProgressBar({Key? key, required this.totalCaloriesBurned}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = totalCaloriesBurned / 1000; // Assuming 1000 calories as the maximum goal
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          totalCaloriesBurned.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 300,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlue],
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
