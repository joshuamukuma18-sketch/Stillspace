import 'package:flutter/material.dart';

void main() {
  runApp(const StillSpaceApp());
}

class StillSpaceApp extends StatelessWidget {
  const StillSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StillSpace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF789681),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7F3),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> moods = const [
    {'name': 'Calm', 'emoji': '😌', 'activities': ['Gratitude Moment', 'Mindful Walking', 'Positive Reflection']},
    {'name': 'Happy', 'emoji': '😊', 'activities': ['Happy Memories', 'Celebrate Yourself', 'Share Kindness']},
    {'name': 'Okay', 'emoji': '🙂', 'activities': ['Daily Reflection', 'Gentle Stretching', 'Mindful Breathing']},
    {'name': 'Anxious', 'emoji': '😟', 'activities': ['Breathing Exercise', '5 Senses Grounding', 'Calm Thoughts']},
    {'name': 'Low', 'emoji': '😔', 'activities': ['Small Positive Steps', 'Self Kindness', 'Reach Out to Someone']},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            const SizedBox(height: 20),
            const Text(
              'StillSpace 🌿',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF526F5C)),
            ),
            const SizedBox(height: 10),
            const Text('Take a breath. You are here.', style: TextStyle(fontSize: 17)),
            const SizedBox(height: 30),
            const Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            ...moods.map((mood) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(14),
                leading: Text(mood['emoji'], style: const TextStyle(fontSize: 30)),
                title: Text(mood['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ActivitiesScreen(
                        mood: mood['name'],
                        activities: List<String>.from(mood['activities']),
                      ),
                    ),
                  );
                },
              ),
            )),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.air, size: 32),
                title: const Text('Breathing Coach'),
                subtitle: const Text('Take a peaceful moment.'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BreathingScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivitiesScreen extends StatelessWidget {
  final String mood;
  final List<String> activities;

  const ActivitiesScreen({
    super.key,
    required this.mood,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$mood Activities')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Activities for when you feel $mood.',
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          ...activities.map((activity) => Card(
            child: ListTile(
              leading: const Icon(Icons.spa),
              title: Text(activity),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActivityDetailScreen(title: activity),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class ActivityDetailScreen extends StatelessWidget {
  final String title;

  const ActivityDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text(
              'Take your time with this activity. There is no pressure to get everything right. Go at a comfortable pace.',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Finish Activity'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  int step = 0;
  final steps = [
    'Breathe in gently.',
    'Breathe out slowly.',
    'Relax your shoulders.',
    'Continue at your own pace.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Breathing Coach')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.air, size: 75, color: Color(0xFF789681)),
              const SizedBox(height: 25),
              const Text('Take a peaceful moment',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text(steps[step], style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 30),
              FilledButton(
  onPressed: () {
    setState(() {
      step = (step + 1) % instructions.length;
    });
  },
  child: const Text('Next Step'),
),

