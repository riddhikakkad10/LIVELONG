import 'package:flutter/material.dart';
import 'package:livelong_flutter/profile.dart';
import 'package:livelong_flutter/signuppage.dart';
import 'meal_page.dart';
import 'progress_tracking_page.dart';
import 'workout_page.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MealPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WorkoutPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProgressTrackingPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(userId: 'omzr7txwacZ46j2IHgcM3VD1Aix2',)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserProfileSection(),
            QuickActionsSection(),
            DailyProgressSection(),
            RecentActivitySection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Meal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class UserProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuickActionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionButton(
            icon: Icons.restaurant,
            label: 'Track Meal',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MealPage()),
              );
            },
          ),
          ActionButton(
            icon: Icons.fitness_center,
            label: 'Start Workout',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkoutPage()),
              );
            },
          ),
          ActionButton(
            icon: Icons.camera_alt,
            label: 'Upload Progress',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProgressTrackingPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          iconSize: 36.0,
          onPressed: onPressed,
        ),
        SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }
}

class DailyProgressSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Daily Progress',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Calories Burned'),
                    SizedBox(height: 8.0),
                    CircularProgressIndicator(
                      value: 0.7,
                      strokeWidth: 15,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Protein Intake'),
                    SizedBox(height: 8.0),
                    CircularProgressIndicator(
                      value: 0.4,
                      strokeWidth: 15,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }
}

class RecentActivitySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          ActivityTile(
            title: 'Breakfast',
            subtitle: '500 calories, 30g protein',
            date: '2023-04-11',
          ),
          ActivityTile(
            title: 'Running',
            subtitle: '300 calories burned',
            date: '2023-04-10',
          ),
          ActivityTile(
            title: 'Progress Photo',
            subtitle: 'April 9, 2023',
            date: '2023-04-09',
          ),
        ],
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final bool showPhoto;

  ActivityTile({
    required this.title,
    required this.subtitle,
    required this.date,
    this.showPhoto = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: showPhoto
          ? CircleAvatar(
        backgroundImage: AssetImage('assets/images/progress_photo.png'),
      )
          : Icon(Icons.fitness_center),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(date),
    );
  }
}
