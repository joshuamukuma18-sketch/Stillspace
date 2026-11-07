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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF789681),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? mood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StillSpace')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Take a breath.',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text('How are you feeling today?'),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: ['Calm', 'Happy', 'Okay', 'Anxious', 'Low']
                .map(
                  (item) => ChoiceChip(
                    label: Text(item),
                    selected: mood == item,
                    onSelected: (selected) {
  if (selected) {
    setState(() {
      mood = item;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivitiesScreen(mood: item),
      ),
    );
  }
},
                  ),
                )
                .toList(),
          ),
          if (mood != null)
  Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mood == 'Calm'
                  ? 'Your calming moment'
                  : mood == 'Happy'
                      ? 'Keep your happiness growing'
                      : mood == 'Okay'
                          ? 'Take a mindful pause'
                          : mood == 'Anxious'
                              ? 'Let’s ease your worries'
                              : 'Be gentle with yourself',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              mood == 'Calm'
                  ? 'Breathe in gently for 4 seconds, then breathe out for 6 seconds. Repeat 5 times.'
                  : mood == 'Happy'
                      ? 'Take a moment to notice three good things about today.'
                      : mood == 'Okay'
                          ? 'Relax your shoulders and take three slow, comfortable breaths.'
                          : mood == 'Anxious'
                              ? 'Name 5 things you see, 4 things you feel, and 3 things you hear.'
                              : 'Take a small break, drink some water, and choose one kind thing to do for yourself.',
            ),
          ],
        ),
      ),
    ),
  ),
        
            
          const SizedBox(height: 24),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'A moment to reset\n\n'
                'Relax your shoulders and breathe gently. '
                'Take things one moment at a time.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActivitiesScreen extends StatelessWidget {
  final String mood;

  const ActivitiesScreen({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'title': 'Breathing Exercise',
        'description': 'Follow a gentle breathing exercise to relax.',
        'icon': Icons.air,
        'details':
            'Breathe in gently for 4 seconds. Breathe out slowly for 6 seconds. Repeat five times.'
      },
      {
        'title': 'Meditation',
        'description': 'Take a moment to relax your mind.',
        'icon': Icons.self_improvement,
        'details':
            'Sit comfortably, close your eyes if you wish, and focus on your breathing for two minutes.'
      },
      {
        'title': 'Positive Thoughts',
        'description': 'Read encouraging words.',
        'icon': Icons.favorite,
        'details':
            'You are doing your best. Every small step matters. Be patient and gentle with yourself.'
      },
      {
        'title': 'Mood Journal',
        'description': 'Write down how you feel.',
        'icon': Icons.book,
        'details':
            'Write freely about your feelings, thoughts and what might help you today.'
      },
      {
        'title': 'Relaxation',
        'description': 'Discover simple ways to unwind.',
        'icon': Icons.spa,
        'details':
            'Find a comfortable place, stretch gently, listen to calming sounds or enjoy a quiet moment.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose an Activity'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'You selected: $mood',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('What would you like to do today?'),
          const SizedBox(height: 20),
          ...activities.map((activity) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(
                  activity['icon'] as IconData,
                  size: 32,
                ),
                title: Text(activity['title'] as String),
                subtitle: Text(activity['description'] as String),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityDetailScreen(
                        title: activity['title'] as String,
                        details: activity['details'] as String,
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ActivityDetailScreen extends StatelessWidget {
  final String title;
  final String details;

  const ActivityDetailScreen({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              details,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            if (title == 'Mood Journal')
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your feelings here...',
                  border: OutlineInputBorder(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
